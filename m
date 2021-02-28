Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19232727F
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Feb 2021 14:54:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DpPy21Lpkz3cQ3
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Mar 2021 00:54:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614520442;
	bh=NViGHg/JMRGnBGNP6knlFwQOpcSBzYN+8MWLM1bSTyE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Lmnantox/sT32sASDjJ0oI8Qj8dsf1R9TeylUu6fkCc8xAK6eJocfihvLmxaTyIKP
	 3dU0ayrr/RmHrPGL1CVQ4XDQ17BvzpDY+7XywAbl7Qm+ILIDgkf+/8bKENs0d+X0pz
	 6yq/lsGg1EDDGQRrhMGoy4Hovje6feb7oxZEBbC+fk9o1fVVrkM65T8LQ+U2a+F5yy
	 Zxl+kVMSODPI2jXHne/UrBbA8dl9cvCLAMDSzmM4F+7oKBSn4dTqvmKisRn/4R+r0D
	 kzo0phwG2ZotAKKVWjbp40kJBMV5PVTvoib8dIZPAEBUpkFmi2OqRANc1nByKJphYD
	 F7iWEUCmqGI7A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.147; helo=sonic301-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=QRsP1WLx; dkim-atps=neutral
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DpPxy41Pjz3cGV
 for <linux-erofs@lists.ozlabs.org>; Mon,  1 Mar 2021 00:53:55 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1614520430; bh=/sClym6qs02GnXv/Ii7M/6gwGC5eAWc0ZXlKlJ4EGWp=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=cqSom62MoZHzDcP7jauTdf0w98kKBRievkrOiCV0TQw5g0kGBG73/lkzFrS6ZyJu1bbWRD2dffw7fxKTFd9DqYqdf6VQ4asmrDPhEzMRHHeQvUne/A6DnKtM1Ul9sQ+dki0xhJiQhw+bHpQegMJLrC91DG86LYfolEy6hy//ga09fcIKG+E/aRJ32deat0wLu4ex+bfzzqjP47fPwsyLWKP9/uERapSS8GtxEHDrj3YKAipKCGmiLw8oClEzuta5X4jjkcvTN2OC5nQtnrsB/5MunyLL4AMNrrbW/0nBgOUd7OgBTYdoTgvwHcaSqw2TyQfK6ruIvt/3veXh9C62NA==
X-YMail-OSG: Uf.tCCwVM1m5YVXOHN2aTSu0DFEWl4vaXI7XM8Ig2.5GAtdIVel6u8xRGilcyK1
 HxC50l0363yDW9aUFQVjNaL1o2KO4c6T2VxJnLLlidJlLpb.EEbbPp4ZpMvnLIU_twM1W67mPfUk
 XflhflDMnb5vZhNmNWp59iHntkwI0YrrTdIbEfecp5q49tXs9Ezmk.9dT19F1d8ONzsmkosQjbKn
 z0KwRhUtZ9C_KlRona8ZlG2vYiNwdJyYOQqc4HZJygO_OK1E16rrfkmGeBJsLGjlDFIsyeus_j4g
 Zrj0R1m64_H7K2h.DJzOcHCwE4m9rDUsBheSM1dMzYv7HLAnlRZ6BPF1NXi10vzERVD7TCfIiWzJ
 zYOrfrcnsPR93GjgsYDGg4Ueg6tR3NdQz.X4Aschf6e37jsBZqoAQyQzf_OCscvJeRU19LVzOk7G
 ZYVFolLqDMGkCv4sizkFUcUW2Is4tzUWY3E..49chtmOurZ3RiMi_5zGubXMm1u2ajfjvzitb4ek
 bQDRnAFHfR3FiCN5y9CKG43g50k8G2I1VtnlK25kbTgcVDgbz2xGcIxyEWRhTcni1hHKr.d.cLfi
 kj4sis0F15kp.USKaO9jKQymNeZsUYI8hyaE47mIiEE3Xp0g7EkwBawQWLBcc94b1f.8BPN_ciT2
 ZdhisHnwSoOin_.4B1X_MIpWQTR147u6fwn7pxKKASu1bJZjNYuPN4uW0P..Swm9ml60rulLKNFE
 265sDWjzFkMxWmVLcNrM87gB0nsjkYVrB2J08hALNkIzk5I.WlqoZO_nF3ENv6AGfkHfy7aAtsAe
 ebeB.ssYqN3UARO_KAMP7fpnW8hKbbAfFymzRZDKCxTgpW1GqLS829H0C5G50axoItal0a3ME9MV
 .V_7e7TxYzDj6b6C9KYUZJgwwvZqFlZeYkbLUUN9KjLNBuCQEr3i5fV77oAymc0V8Tde.MDWTSJp
 .9j2CFc8GxItj5shBkxnogr7LadNvwkouwsK55vihD_1m29Awonk5te6UhmVi.QEY8WeWxtEfjSR
 PCydLipZsHCHs.MjWfHGUGwhAN5MJ6UFuJQXuGTFjyNDm_zYxb.sSYoPpKkuWwWm6Br.VaRRp0lq
 HsdxYiZGIqvdsBI4FPcanf2aZUg7gVyfaYengOYJqPrJ4uy44GgBSD_0KL1nkAqGE_FF59GTHhtF
 Iv8pYMsxQOUXZHbJcsmfiHx1Xb0O31m03.uTfGAUxjx0xgTUasehF6VaMTwOlmJWDgkE16t8aiEW
 vLiMZ3gn6DnRu3mpYn8DbgEAw0Wm7SP_.qlkpexYyqcMPjgSO1XCQyTZb4TlYYUnQL7q.Ivxjhoq
 bDOzXaZzNsoz4cuj9yFEj6ZqGBnfOu41mlIT9DwENGgYxlXdtdpic9KhWSxCUzrQ_KVwNHH7wt.T
 LHh8boP0HKEd5Fvc3pF6tkXcwk.94NB9UdZI5ec8ymtsXXDzDsJN0ORMldklrBz8hmxzHnFLqD_i
 DQjvnu5ArXmCssOKrp7r0Q7v6L15SsFQIHqM5iGLgkvbomwyfc3ueod8oBq9t_PPOrpe59tQi30S
 orpNmqk4Aejjnm3rbz9mlitHoafBz1_w5UmdzDmprwmd8zKLbxNHWvGdDb_VnjityqDTj6uk7a52
 idkAVkEbRq_xPGhYKTEM2hxbNvNRo.qGgDQNwbZcBy0CCtQrAEPBz8uZ2Jk2SJfYvKX11G7ljX6t
 Id_oegB6GCMtEMlg6OeiTR36lFA17cvWCaNx2foaPjQbySZKeFudooY1z7LsaKcn4toRKAzMzbZx
 UktWwNzgJdMOzz1vTrjY51WzESY7T32SbUKz.ciewMjFKlAeJtY3pX5hFWh60yyfYEF9.2snFULY
 X2u4KfDFZi.Ht8ISQfwuUjCHXCQb3Du7J7hFWKbULmLkWhX.QpFkWce8UAma6r7X0g3b3JUfY32s
 RThAR4ouZOqklTYphDkkZ38jM8Kr07oDksEDMOh5N5GrjZ_uzU2CjMAs2DopeFq0Kr8Gux_j50kg
 z7MLHii8_B3b2z.ZwjecaAM25Wf2c_bfvtSqFAAdFC3llCcjc8oZ.7r8dh5A2Jqv9KM.Fft_9KBO
 pNDNuTCKhfK_jXXBS21xHcDsOWfOukUZ9RlOL0tWKTbaUJzQwx0ysgDLJOe0rd4p5aaQC3DCjOKI
 xMYLJ..6H8OLf9lCiWUNxwrDWUXMQKg.iCh5IRllux5Zm__mK..uZudazhrKQzOB9LkUzqj7ISyd
 VHP7Cj0tqutLBpYJYpkAAMPOSSr0xtSaewAx8tevmmnrFK3q1Hi8vGWtFdi1LdzewdV.bc9IpSIa
 8pll0d2_8_SevM9JkJXa2qk.HSkmZbri.HyeBSW_UB0A6.8NhoToBYEHmejK.nc4Yrwt96Q.hwHN
 dfjmhw_1J_jxc34WN13I8bsTUYY0KNkjE.Tk27JnmEGDcczeHs_ambnw50is.Jubq1lglyqhklz6
 joeYhCzF3iDUgw0HECSGXJCctgnwdjKFSFfUGuvQu4MLK0TQ9pFqH.adPQQoJRyZTDC1SnEJh3TI
 Wriliv0dVzaq_eXKaah6KI837_Khq6QcwRpXKrjsnxpGUoupUbcpWWw--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 28 Feb 2021 13:53:50 +0000
Received: by smtp418.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0a17c6d53b469820b2591dbac94cb7be; 
 Sun, 28 Feb 2021 13:53:46 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: fuse: fix random readlink error
Date: Sun, 28 Feb 2021 21:53:12 +0800
Message-Id: <20210228135312.4373-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210209193845.GA13059@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210209193845.GA13059@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hu Weiwen <sehuww@mail.scut.edu.cn>

readlink should fill a **null-terminated** string in the buffer [1].

To achieve this:
1) memset(0) for unmapped extents;
2) make erofsfuse_read() properly returning the actual bytes read;
3) insert a null character if the path is truncated.

[1] https://lore.kernel.org/r/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn
Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Reviewed-by: Li Guifu <bluce.lee@aliyun.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v3:
 - fix z_erofs_read_data() buffer range as well.

 fuse/main.c |  8 ++++++++
 lib/data.c  | 46 +++++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index c16291272e75..37119ea8728d 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -74,6 +74,10 @@ static int erofsfuse_read(const char *path, char *buffer,
 	ret = erofs_pread(&vi, buffer, size, offset);
 	if (ret)
 		return ret;
+	if (offset + size > vi.i_size)
+		return vi.i_size - offset;
+	if (offset >= vi.i_size)
+		return 0;
 	return size;
 }
 
@@ -83,6 +87,10 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 
 	if (ret < 0)
 		return ret;
+	DBG_BUGON(ret > size);
+	if (ret == size)
+		buffer[size - 1] = '\0';
+	erofs_dbg("readlink(%s): %s", path, buffer);
 	return 0;
 }
 
diff --git a/lib/data.c b/lib/data.c
index 3781846743aa..56de16b3c840 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -29,6 +29,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 	if (offset >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
+		map->m_plen = 0;
 		goto out;
 	}
 
@@ -80,6 +81,7 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	erofs_off_t ptr = offset;
 
 	while (ptr < offset + size) {
+		char *const estart = buffer + ptr - offset;
 		erofs_off_t eend;
 
 		map.m_la = ptr;
@@ -89,29 +91,30 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 		DBG_BUGON(map.m_plen != map.m_llen);
 
+		/* trim extent */
+		eend = min(offset + size, map.m_la + map.m_llen);
+		DBG_BUGON(ptr < map.m_la);
+
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 			if (!map.m_llen) {
+				/* reached EOF */
+				memset(estart, 0, offset + size - ptr);
 				ptr = offset + size;
 				continue;
 			}
-			ptr = map.m_la + map.m_llen;
+			memset(estart, 0, eend - ptr);
+			ptr = eend;
 			continue;
 		}
 
-		/* trim extent */
-		eend = min(offset + size, map.m_la + map.m_llen);
-		DBG_BUGON(ptr < map.m_la);
-
 		if (ptr > map.m_la) {
 			map.m_pa += ptr - map.m_la;
 			map.m_la = ptr;
 		}
 
-		ret = dev_read(buffer + ptr - offset,
-			       map.m_pa, eend - map.m_la);
+		ret = dev_read(estart, map.m_pa, eend - map.m_la);
 		if (ret < 0)
 			return -EIO;
-
 		ptr = eend;
 	}
 	return 0;
@@ -137,19 +140,6 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		if (ret)
 			return ret;
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			end = map.m_la;
-			continue;
-		}
-
-		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
-		if (ret < 0)
-			return -EIO;
-
-		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
-						Z_EROFS_COMPRESSION_LZ4 :
-						Z_EROFS_COMPRESSION_SHIFTED;
-
 		/*
 		 * trim to the needed size if the returned extent is quite
 		 * larger than requested, and set up partial flag as well.
@@ -171,6 +161,20 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			end = map.m_la;
 		}
 
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			memset(buffer + end - offset, 0, length);
+			end = map.m_la;
+			continue;
+		}
+
+		ret = dev_read(raw, map.m_pa, EROFS_BLKSIZ);
+		if (ret < 0)
+			return -EIO;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + end - offset,
-- 
2.24.0

