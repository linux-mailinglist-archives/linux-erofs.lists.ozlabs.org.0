Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 25924852F7
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 20:27:20 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463g2s1DmrzDqws
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 04:27:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565202437;
	bh=hhXf/ok7ALLE1jx8rNk8ueS65Y4kXHkgIGzXWZ90bnY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZSzFCGDpi5EyICDawOtEks23hxM4OXLRESVns+IsuSEJX7u+X9kOL9IJjgFmJXQUz
	 h1yRAucCaGHVCuk7bhqO50Cv6lernqIEG7yXDaxuBY80wzir4OAtq2YcFR34vtmPnM
	 +I9jLBxwe3pKUKxvn9VKRnpqEJYRn1wjt3OE+5grV5IPT2QpLCy7fXOTW+Z0L3id/G
	 sbNOosIcM1ygU+OAFw3KiHS7TmjN6fKks6N3/7599YLA2Zb4AS3VtNp7aCmOXUXjcO
	 HTDCP9s+/uugeJVvixS+ACc+pCiJGmQt6U56Q8XUhfzcJ6q7YhwTKf8xjgpiJq6gql
	 ueHLl/UPJd4Ew==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.32; helo=sonic310-11.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="az0TwJYY"; 
 dkim-atps=neutral
Received: from sonic310-11.consmr.mail.ir2.yahoo.com
 (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463g2f2GhhzDqwJ
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 04:27:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565202418; bh=bMlxGJPqroxMPd7a+jasrnmG8qZbhh5jwOKXOQ99Q98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=az0TwJYYsEk+xRBW1aZKxR+jolI/zrW8JcCsHxMQim6xYqxaNE6k+v0nLn5OxwL7ltUHmzRmJZdfggtMgqOPWTOmLGnm3JM3Q5kkXuiyw6pSf8f8QcIBG5BQcEcBVYLzDjdi4JGSzekMme4NYMFvE2NrTvNhNVNtApVluAMajJa5JQcCYN7GXS727r5V3nOSGYHDrql1oIIwrjGUDrn4/QkrHauy0gJIzbKEJSvpIi0TQBYjjq3gImdkuz6NMEDjKZF47mSo8u5tCChG0mPvj/T8kyKJfjIHMxeYM/+kBPEMzTvgV9iHVCm7DEdQYHccOvofTxnU+n6NsYaVzJumng==
X-YMail-OSG: m3bs1rMVM1k2ydYkKGW.rL_ICRbuDUvHVK3JUh8yu1OTHpf9U8FERLgicW8usNb
 ZonX5L9RWpUJeUuzVK8cOYaT2.lR3IOjjvg2.M6g2mCzmjPNSIXPXta41QlMKoSAtypBxNJSlg2u
 bMWeN4LY8vD_4MfOlqpA_lgm.vnkyAnXjAb2kOgRcP0WVaRVLOPa5LUpJf7x0AxR5ShQhdv0fkGy
 dBGLi5tecK0G6ANlE8L5ksK5VXeyfScibCxC8cNSrnJ_sBjBYIkvgly0bTlsLA0y6e3rsHzoiX6m
 LPEkE9H4VgqSa.8q4qVDkgYE6TQdL.zOVUvQ5MyEV.VD03BGK38UUJt7goODCTmUAepbDHWeJVq6
 .5DEC9df.Ba9H42Gu6iqWPcTsui2vmoMWQ71qfXce5CUeUN_G.QK1EETNEmV_TStDre.Swr_CeXT
 4QT9aSp0JU0useUtBWSeURd1Ve9L0m.SVVNipDJ649vOX0zIwOtQ.I.WjyjcalXf7d0WzTq0lvzx
 k0CaMhX2CKHk9J67GxmmLImQxv2oGAC7AhMb3kh6KEx4XMK06fA_PfMFIsbfmRGD8os07H_IUYwE
 8APOUJ8MvrluNfjuAAquEuin4CmMGNJX3pJAUk247ChlC9HJ5UbV83SB932SgHb70_Z5jXJizT8L
 M0bYb8.sn8vbeVU7TNYdtcjrThpdv06iSH08bDzHHY.v2eGQ7boONoJEsSLcCAZs1r2uTKju1j.V
 kNaTa9KkF9Q_fcQSXb0ifTMGwup6s2qrF9oVLiev4GeG.af5uLW6nD556zyE4Ay_WTGvE6iBwrUW
 OMXhVnDwdC8Hgp6.XC.WVS8ilsFIeOVgu6Sq7SCWI9OqgGCwpDvAlBUSOEZCDv_ukEeVdIR_SpIi
 U6Z11MEgh6rYhJAt31oueL5QxI8ddrNXo5wieawUCGuRlb5Qn4fTerEsaKtkAGcPSJ3V6bGeQHLt
 T1I1C_R5fF17goUAf.G11Mfwcox5nev6OSeRy4G2.V2rFIPrGrWAJ2_RV76WjmY2Kdy30yLJ8gHn
 LhSZO1ygtgfXVdQ0uni14LyqDXC.AmLWbWGHfewAiH_8XNpGGZQaApg1CdPaE6_.lk0LU0wkbZHK
 RaENX.E3pIpO.SEwEr5arsL8Chf44uQnMDaeZSUdk_BqeXq5cYGby5xSFTvnrhWMilzvLf_HllNj
 l37DNQByHPktu8YCAVV.AH55nfFpSLquestJDviIS2bMoaOZhi.1Kec5CQsKZ.sXJldexy4pOy4f
 nY98ZfmDiW1Asd2PWES9gjDN14eG7zKY0Y36dAdDsPTM-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ir2.yahoo.com with HTTP; Wed, 7 Aug 2019 18:26:58 +0000
Received: by smtp410.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID be6e89897651d9c4e839a16ea069ee58; 
 Wed, 07 Aug 2019 18:26:56 +0000 (UTC)
Date: Thu, 8 Aug 2019 02:26:50 +0800
To: shenmeng999@126.com
Subject: Re: [PATCH v2] erofs-utils: get block device size correctly
Message-ID: <20190807182644.GA13848@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1565188615-19591-1-git-send-email-shenmeng999@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565188615-19591-1-git-send-email-shenmeng999@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi shenmeng,

On Wed, Aug 07, 2019 at 10:36:55PM +0800, shenmeng999@126.com wrote:
> From: shenmeng996 <shenmeng999@126.com>
> 
> fstat return block device's size of zero.
> use ioctl to get block device's size.
> 
> Signed-off-by: shenmeng996 <shenmeng999@126.com>


Thanks for your patch v2 :)

It looks good to me, and I update this patch so that
autoconf can check these new header files.
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=0f225449962b4a9716985e7530a395a9500d0de6
Do you agree with this modification? please share your thought about this.

Thanks,
Gao Xiang

diff --git a/configure.ac b/configure.ac
index 6f4eacc..fcdf30a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,12 +73,14 @@ AC_CHECK_HEADERS(m4_flatten([
 	fcntl.h
 	inttypes.h
 	linux/falloc.h
+	linux/fs.h
 	linux/types.h
 	limits.h
 	stddef.h
 	stdint.h
 	stdlib.h
 	string.h
+	sys/ioctl.h
 	sys/stat.h
 	sys/time.h
 	unistd.h
diff --git a/lib/io.c b/lib/io.c
index 93328d3..15c5a35 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -9,7 +9,11 @@
 #define _LARGEFILE64_SOURCE
 #define _GNU_SOURCE
 #include <sys/stat.h>
+#include <sys/ioctl.h>
 #include "erofs/io.h"
+#ifdef HAVE_LINUX_FS_H
+#include <linux/fs.h>
+#endif
 #ifdef HAVE_LINUX_FALLOC_H
 #include <linux/falloc.h>
 #endif
@@ -21,6 +25,26 @@ static const char *erofs_devname;
 static int erofs_devfd = -1;
 static u64 erofs_devsz;
 
+int dev_get_blkdev_size(int fd, u64 *bytes)
+{
+	errno = ENOTSUP;
+#ifdef BLKGETSIZE64
+	if (ioctl(fd, BLKGETSIZE64, bytes) >= 0)
+		return 0;
+#endif
+
+#ifdef BLKGETSIZE
+	{
+		unsigned long size;
+		if (ioctl(fd, BLKGETSIZE, &size) >= 0) {
+			*bytes = ((u64)size << 9);
+			return 0;
+		}
+	}
+#endif
+	return -errno;
+}
+
 void dev_close(void)
 {
 	close(erofs_devfd);
@@ -49,7 +73,12 @@ int dev_open(const char *dev)
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		erofs_devsz = st.st_size;
+		ret = dev_get_blkdev_size(fd, &erofs_devsz);
+		if (ret) {
+			erofs_err("failed to get block device size(%s).", dev);
+			close(fd);
+			return ret;
+		}
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
-- 
2.17.1

