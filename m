Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27702FF0A2
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 17:40:38 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DM7Rl4ShBzDrS9
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 03:40:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DM7Qy1lLJzDqVT
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jan 2021 03:39:53 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowADn7eFDrglgpLbbAQ--.1175S7;
 Fri, 22 Jan 2021 00:39:34 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/7] erofs-utils: tests: fix memory leakage in fssum
Date: Fri, 22 Jan 2021 00:37:11 +0800
Message-Id: <20210121163715.10660-4-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
References: <20210121163715.10660-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowADn7eFDrglgpLbbAQ--.1175S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW7Jr4UCr18Cw4xAr15XFb_yoW5GFykpa
 1SyasYvr18AryxtwnrX3s8CasIg3y3tr1UCayqywn7Za45Jr1vg343tFWSgF98JFySvr48
 Ary5ZrW7uFs5Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWUMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRiL05UUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAZsB
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 tests/src/fssum.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tests/src/fssum.c b/tests/src/fssum.c
index 10d6275..0f40452 100644
--- a/tests/src/fssum.c
+++ b/tests/src/fssum.c
@@ -31,6 +31,7 @@
 #include <endian.h>
 
 #define CS_SIZE 16
+#define CS_STR_SIZE (CS_SIZE * 2 + 1)
 #define CHUNKS	128
 
 #ifdef __linux__
@@ -209,16 +210,13 @@ sum_add_time(sum_t *dst, time_t t)
 	sum_add_u64(dst, t);
 }
 
-char *
-sum_to_string(sum_t *dst)
+void
+sum_to_string(sum_t *dst, char *s)
 {
 	int i;
-	char *s = alloc(CS_SIZE * 2 + 1);
 
 	for (i = 0; i < CS_SIZE; ++i)
 		sprintf(s + i * 2, "%02x", dst->out[i]);
-
-	return s;
 }
 
 int
@@ -523,7 +521,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 		exit(-1);
 	}
 
-	d = fdopendir(dirfd);
+	d = fdopendir(dup(dirfd));
 	if (!d) {
 		perror("opendir");
 		exit(-1);
@@ -547,6 +545,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 		}
 		++entries;
 	}
+	closedir(d);
 	qsort(namelist, entries, sizeof(*namelist), namecmp);
 	for (i = 0; i < entries; ++i) {
 		struct stat64 st;
@@ -674,21 +673,19 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 		sum_fini(&meta);
 		if (gen_manifest || in_manifest) {
 			char *fn;
-			char *m;
-			char *c;
+			char m[CS_STR_SIZE];
+			char c[CS_STR_SIZE];
 
 			if (S_ISDIR(st.st_mode))
 				strcat(path, "/");
 			fn = escape(path);
-			m = sum_to_string(&meta);
-			c = sum_to_string(&cs);
+			sum_to_string(&meta, m);
+			sum_to_string(&cs, c);
 
 			if (gen_manifest)
 				fprintf(out_fp, "%s %s %s\n", fn, m, c);
 			if (in_manifest)
 				check_manifest(fn, m, c, 0);
-			free(c);
-			free(m);
 			free(fn);
 		}
 		sum_add_sum(dircs, &cs);
@@ -696,6 +693,9 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
 next:
 		free(path);
 	}
+	for (i = 0; i < entries; ++i)
+		free(namelist[i]);
+	free(namelist);
 }
 
 int
@@ -713,6 +713,7 @@ main(int argc, char *argv[])
 	int elen;
 	int n_flags = 0;
 	const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
+	char sum_string[CS_STR_SIZE];
 
 	out_fp = stdout;
 	while ((c = getopt(argc, argv, allopts)) != EOF) {
@@ -871,9 +872,11 @@ main(int argc, char *argv[])
 		if (!gen_manifest)
 			fprintf(out_fp, "%s:", flagstring);
 
-		fprintf(out_fp, "%s\n", sum_to_string(&cs));
+		sum_to_string(&cs, sum_string);
+		fprintf(out_fp, "%s\n", sum_string);
 	} else {
-		if (strcmp(checksum, sum_to_string(&cs)) == 0) {
+		sum_to_string(&cs, sum_string);
+		if (strcmp(checksum, sum_string) == 0) {
 			printf("OK\n");
 			exit(0);
 		} else {
-- 
2.30.0

