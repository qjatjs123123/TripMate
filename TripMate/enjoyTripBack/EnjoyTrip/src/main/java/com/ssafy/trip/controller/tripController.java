package com.ssafy.trip.controller;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.board.model.BoardListDto;
import com.ssafy.trip.model.tripDto;
import com.ssafy.trip.model.service.tripService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/map")
@CrossOrigin("*")
public class tripController {
	private static final long serialVersionUID = 1L;
	private static final int INF = Integer.MAX_VALUE / 2; // 무한대 설정
	private tripService tripservice;
	
	public tripController(tripService tripservice) {
		this.tripservice = tripservice;
	}

	@GetMapping("/")
	public ResponseEntity<?> getTripList(
			@RequestParam("areaCode") int sido_code,
			@RequestParam("contentTypeId") int content_type_id,
			@RequestParam("keyword") String title,
			@RequestParam("pageNo") int pageNo,
			@RequestParam("userId") String userId) {
		try {

			List<tripDto> list = tripservice.getList(sido_code, content_type_id, title, pageNo*10, userId);
			
			if (list != null && !list.isEmpty()) {
				return new ResponseEntity<List<tripDto>>(list, HttpStatus.OK);
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/meet")
	public ResponseEntity<?> meet(@RequestParam Map<String, Double> map) throws Exception {	
		try {

			List<tripDto> list = tripservice.getListbyLoc(map);
			
			if (list != null && !list.isEmpty()) {		
				return new ResponseEntity<List<tripDto>>(list, HttpStatus.OK);
				
			} else {
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			}
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
		}	
		
	}
	
    @GetMapping("/latest")
    public ResponseEntity<?> getPopularArticle(HttpSession session) {
		try {
			System.out.println("최신여행지 가져오기!!!");
			List<tripDto> list = tripservice.getLatestAttraction();
			System.out.println(list);
			for(tripDto t : list) {
				System.out.println(t.getTitle());
			}
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
			return ResponseEntity.ok().headers(header).body(list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("서버에서 문제가 발생했습니다.");
		}
    }
    
    @GetMapping("/short")
    public ResponseEntity<?> getShortPath(HttpSession session) {
		try {
		}catch(Exception e) {
			
		}
    }
	
    public static int[] tsp(int[][] dist) {
        int n = dist.length;
        int[][] dp = new int[1 << n][n];
        int[][] parent = new int[1 << n][n]; // 경로 추적을 위한 배열

        for (int[] row : dp) {
            Arrays.fill(row, INF);
        }
        dp[1][0] = 0; // 시작점은 항상 0번 도시

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int u = 0; u < n; u++) {
                if ((mask & (1 << u)) != 0) { // u가 현재 집합에 포함된 경우
                    for (int v = 0; v < n; v++) {
                        if ((mask & (1 << v)) != 0 && u != v) { // v가 현재 집합에 포함된 경우
                            int newCost = dp[mask ^ (1 << u)][v] + dist[v][u];
                            if (newCost < dp[mask][u]) {
                                dp[mask][u] = newCost;
                                parent[mask][u] = v;
                            }
                        }
                    }
                }
            }
        }

        int minCost = INF;
        int lastCity = -1;
        int endMask = (1 << n) - 1;

        for (int u = 1; u < n; u++) {
            int cost = dp[endMask][u] + dist[u][0];
            if (cost < minCost) {
                minCost = cost;
                lastCity = u;
            }
        }

        // 경로 추적
        int[] path = new int[n + 1];
        int currentMask = endMask;
        int currentCity = lastCity;

        for (int i = n; i > 0; i--) {
            path[i] = currentCity;
            currentCity = parent[currentMask][currentCity];
            currentMask ^= (1 << path[i]);
        }
        path[0] = 0; // 시작점

        return path;
    }
	public static void mergeSort(List<tripDto> list) {
        if (list.size() > 1) {
            // 리스트를 두 부분으로 나눈다.
            List<tripDto> left = new ArrayList<>(list.subList(0, list.size() / 2));
            List<tripDto> right = new ArrayList<>(list.subList(list.size() / 2, list.size()));

            // 각 부분을 재귀적으로 정렬한다.
            mergeSort(left);
            mergeSort(right);

            // 정렬된 부분들을 병합한다.
            merge(list, left, right);
        }
    }

	
	
    private static void merge(List<tripDto> result, List<tripDto> left, List<tripDto> right) {
        int i = 0, j = 0, k = 0;

        while (i < left.size() && j < right.size()) {
            if (left.get(i).getTitle().compareTo(right.get(j).getTitle()) <= 0) {
                result.set(k++, left.get(i++));
            } else {
                result.set(k++, right.get(j++));
            }
        }

        while (i < left.size()) {
            result.set(k++, left.get(i++));
        }

        while (j < right.size()) {
            result.set(k++, right.get(j++));
        }
    }
}
