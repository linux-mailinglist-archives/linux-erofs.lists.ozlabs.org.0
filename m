Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ACE3156EB
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Feb 2021 20:39:14 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZtW34xPHzDvXY
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Feb 2021 06:39:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612899551;
	bh=clSt2rq8A0cplvNQ7Kgase8YKmDkgWcd0VtiOUIPtvY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=O61Rqdo4gJHpI2x78of52sn2KLGoVSFMIIyC0mxkHV81BhDkP16K4mb7OpyJJRuY1
	 g/M5vUPrATeR5jEVRogoMWxQaiORa5NwArJ1PXJqjOkfZ3VN5/gCVkZhgVxLWwNbpj
	 8hNNV3dro7bs+pGTGc7mK9OQ5UHzjRuFvGY1G0zXvX7kCLobb7s1lwsNliSqjkcRgW
	 wG0Wx7qlPgKkiVX0CIbVcPjIZihOv+CpTXErzMqsw+JkG7jFGN7baP1YyEpXAnSvs3
	 eUlJOBFbel1D7Gmv4F4Ts21I28pA1N9n+4NpoqqqW8LOU9q/hs4SFhbr7a45YU7WIW
	 7Mv3VJ3ThbUbQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=UzS8vp3o; dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZtVx0cSwzDrgL
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Feb 2021 06:39:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1612899538; bh=xHtyJ0YBbI/KssJIPFUUe5mm+CFnc8/MmKb0Q4BIpwo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To;
 b=UzS8vp3oSF/5gvXJcT5eNiUOSOmATQzuShAl6qKO4lRpJBwoS3xUYr5ChN6frLGeVu4dxIhrmbaQ5uhthJX8tCazCpQgNpo38Ue58ruHC4DTqPR8I1k8PL1Tx4C0c/hGHAZfgB0TFifrIkmtYXcL7BqH0VcEq5G5jZcVqxlAgMZez2trDj1/3eHjqWJLE5X0KeJs3Rwtj2Zn1Gbr0WiUzYYItUv0+mzbZOpJ1rOQglGkBME6IJDfsDYOdv+yUL9jhvSpHUdypiq9Kx8rzneKHUGUSd/GZOviOSVVaYo4QvM+PPqIk+9xG9N419NyHOTbDOYIKD2UoIboKboSqTN5/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1612899538; bh=59pdkZGuU1iV1Y8aAtOunRpDzNzpJ99h02S6cJ/kNVm=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=L16Ls2kRtOE65p8vj06Pd767eu8iOxZUR2P/zpGcwYeYaVIMvwWipD+6hSONjSgGd8XFOlwF4JC6M4zYbVZKXz3TKOoVGYT+87HYCpFhJiBfNxgcXCmU6wCIfoAUrnSJrz55xcrgaqsYs8vTdwj6ZaPOvseTOkTNjpFHEgECMFWtPHoj1vfZWmCFwhuj+MQxE6OS0mvCaqFaX3/wQek2gzfQEavhKNtPTyljuXXFC/s8sG1uNcCZTrKUdgTuO/jgXZBVsGRBLzB+Fy8xg/hd/Kg5+gnZnkHMNCGKQJRyPbxup/2yaspAUfBfuqq5RdIZh3p7aICHKy8VCq5LnjavbQ==
X-YMail-OSG: nhCMU3kVM1lbCzm_G9wfxPvAOXzMmsj.06.5oB_9fAqa.iUSyLh0LfvhmewR3Mz
 I7fDLHmrgX_Me2SEI2CfsPpEtMbhIpwpI1vd_ovfF0PPKXPQ3A.h1ETudfMwnAMABXWv0wt2StHn
 bGlTCv.RJI1aNjCwsatJbDgasev6VUosuea5iLZ3EKlxJst9KCDSMzYIeIPnbODKESn7nWeztABq
 0SVZCnHypeWB7I0YNfXJWb8nLRSO7Fr4AJjU07ScaXcdKvowm5LUmkQNMK6NoO18UUz_AqB7nYEQ
 .MUapSk5SCf55.tBX49SN37k9mqzm1sKawONOTRsIhSVPe4Qbu3WKarMZgAjtRO0Fwr3qEG073n4
 n0Gi0.8aKDdp6RL6ChH9g675u7DEz89Lhc1NOSz3EHAf2QTKPSygB0x_moA2vUrMlDFm0rkTabrc
 DNmXHFpbgj2L4CmjNvxwc.uvIyA1YFvH5pws.SKpGSgrsp_DHH_UVgye7oZ7ivhl_3R.SRKmbr8L
 xqEzcwuXSCW9Zv0AbMVBuYdQzfj6nKsTdbzJrkEjMN9a9k7fnGtyfrAiItzqXdnLIzpb1f_AvCkk
 qtvgcrWjD7T2bOjcuRYSwrCBG69IsIl5UlbKYtQJkZOjKrkPZtyLHX5JNIiTjPTlJWH4L6NJh7wU
 nwrok6G03fcL2I7Zv7DtE2Gf535kVkCEa2MShT7Mvs_4CtYD223W9fTuIwUcwqjU.PwZrdBrWnC4
 vgCVAnrf9AkiNAfPZVd1cHHQrXQsE8FHkLXJ.OgVOvwYO_4UwWrlSg8Xp96N3BWLYnTDmUESIuWs
 izuFxfzDNiUlkY8CwDbDKlytzwJe_aACiJjezunBeC_iVtvJGcg9iRaOMZwRVlP8R70qrYCtT1fv
 eZYZiVx3mP29TnPQmNGYdVDv2AYksUG96KtainVvQzb67n1LsAM6Exwxkp4QD.CErixj68GDzQBT
 dazFhUGwm9udwZZppoJ2FW4HW0YN7HmZn6.bVTMfeMLp9f2BIgAab68Hm5rSBIKUmby7sWgEfSlP
 XeswnwO9Zdl2mp5v_AC5QAgI85_M3nwmFnl3U2ydOjK8aeyOkQKgg4C1gBQ85SQhKywzVN5zl9al
 8ey3p8G4lF65tzDGsSoqlEItrDJk8IOYg.VwaEaHsZeBgqrvw14mnODI9URWQy9Fl.JsHIG4P7Iy
 qil1wM.yyjzdxiUdETb9biy4yLqdYKMURhTNKm6035J7BYHGBnxaqJAXxaYbX_5onEjU7GhoMCNB
 RMjt3vsPwjPAhJp.fmKKg4FRo8ZIlyFMmblWlD0XUumOgt80Ks8mJcO2osW8iUW9OqggQ9Fmoon_
 I7FdTIxaxLwG7GSllEt766oOwtzBW6lZXsLEIPFYK_x3dzr2aLRDtH106F5PKEYN45yKcQMTv2wj
 eUp7jPSP21zctVXhac1VSz8Lm8OevXIaMVsqO4AO0FSs7S4eUoF8KiO.vICes5OG9vsW6cWDM6AO
 MM8qUadUvxIZuOGj3uDo8EcMGhYSAapFBCd8wKj.6mrH.PV9gLXAJO0h6QblcsnDPdmKZBLOVioc
 GEyYwqwKb9viYeUIKuZ9UsDwLgheQH4GvLCzic94bgfPiAfOiTpzjo8O4UlW.DfKYF4Z5O40CWX3
 a4zs.S5s.niwbcBsGnsQEgtdd9UZLlPCSxZbORziZsX46b8wfhAy9MCJ2W6s8VNvOoM8XcM4jfga
 lieNmpRQFmftJG3n8XLnSVV5BGRySSvhdfAgKCtcf6rN1L7v0uzihT2zdbeQ_4vxSQWiVdXMh1tU
 D4Qllzg4VkFgifT2iaOKpKp3vtVWZ6KQ4XQRjIBUWiLwkl.MCMm83d46.F_p8kxOPPt3_9Ik0nDL
 53NO9EnjklsAYqv33AeXLmyq3zFIPkJuHCT5T.dFkcBqbwslnIJNwsxZ8lm1uQwWh2PxH44YBSVo
 sCwMoxFfPbLt8jWmH5HtH8Gl8GXpp7DNNL1dgo3zeIWTjwGmzxmW04hAK6seaptr_1qXMJ_tP6ta
 eVlMZRqyoC5QLsZ5gk2luWligRuuPCefhmbyV6UWuxJDuUPIl6a0XaOU59RpTeAk4rh3uPfGXmX9
 ss3ejFGqnJNPcdPpIgj0SWW0.RgeHw4Ssbg_w6elr8GNvhFj3oey.Og7yWk2hI2IKV7GaCEzALfz
 k23in2fG0NzMqiQORGgmdxdn9KQ35s8l8JiOmIcv1OqEpxIUedIInB2BfEp1j2r9a4B_O70k7rlQ
 dgrW2gqc_6xWzFYA1sTerXDFT8JOlM9AZahK3nWq4siWJZcButAjBsWKFWAwPLyQXnzOq5wnmNx6
 Zvj1kmIQ8kTaIB7n2W09QIZW4Ki6Q4iKdpI97u9LE.NnFsYkDo1ERkKhLlW_ZDnynVQqN_Qy1_Dx
 KdeM2N_somo3Qy77EjzPtGpT2fCgvfcdjwzplFwzYf9eOulbXNR8635lFC1ppT2tqcY4zDGXgKkt
 rRgHrSLO_qzCu75emhef6QUT8R0111DBVf6Vtzoq7CbgP4SXWbPm8DYrca66devKdZpl_GSpSUrG
 hyhFqOgQz._dJ1mkR1wVeQkAzBHpRlxJTZqfOdA--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Feb 2021 19:38:58 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 97893050ac278a439a2d117833933134; 
 Tue, 09 Feb 2021 19:38:56 +0000 (UTC)
Date: Wed, 10 Feb 2021 03:38:50 +0800
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH v2] erofs-utils: fuse: fix random readlink error
Message-ID: <20210209193845.GA13059@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210123152213.GB3167351@xiangao.remote.csb>
 <20210129180747.67731-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129180747.67731-1-sehuww@mail.scut.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.17648
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Sat, Jan 30, 2021 at 02:07:47AM +0800, Hu Weiwen wrote:
> readlink should fill a **null-terminated** string in the buffer.
> 
> To achieve this:
> 1) memset(0) for unmapped extents;
> 2) make erofsfuse_read() properly returning the actual bytes read;
> 3) insert a null character if the path is truncated.
> 
> Link: https://lore.kernel.org/r/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn

Looked into this patch just now...

The Link tag is only used for refering to the patch itself.

> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---

...

>  
> @@ -91,9 +92,13 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>  
>  		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>  			if (!map.m_llen) {
> +				/* reached EOF */
> +				memset(buffer + ptr - offset, 0,
> +				       offset + size - ptr);
>  				ptr = offset + size;
>  				continue;
>  			}
> +			memset(buffer + map.m_la - offset, 0, map.m_llen);

There might be some minor issue --- `offset' could be larger than
`map.m_la' if sparse file is supported then.

I made an update version of this to fix these (some cleanup is
included as well), it would be nice of you to take another look at
this as well...

Thanks,
Gao Xiang

From bfbd8ee056aca57a77034b8723f3f828f806747b Mon Sep 17 00:00:00 2001
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
Date: Sat, 30 Jan 2021 02:07:47 +0800
Subject: [PATCH v3] erofs-utils: fuse: fix random readlink error

readlink should fill a **null-terminated** string in the buffer [1].

To achieve this:
1) memset(0) for unmapped extents;
2) make erofsfuse_read() properly returning the actual bytes read;
3) insert a null character if the path is truncated.

[1] https://lore.kernel.org/r/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn
Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c |  8 ++++++++
 lib/data.c  | 20 ++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

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
index 3781846743aa..5bc525f19826 100644
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
@@ -138,6 +141,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			return ret;
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			memset(buffer + map.m_la - offset, 0, map.m_llen);
 			end = map.m_la;
 			continue;
 		}
-- 
2.24.0

