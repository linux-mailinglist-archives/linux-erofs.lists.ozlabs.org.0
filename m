Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E160185864
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 05:03:38 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463tVc2Qb8zDqTF
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 13:03:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463tVQ1m8YzDqSH
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 13:03:22 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id A60A023DF0B1FF66032B;
 Thu,  8 Aug 2019 11:03:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 11:03:16 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 11:03:15 +0800
Date: Thu, 8 Aug 2019 11:20:24 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: shenmeng999 <shenmeng999@126.com>
Subject: Re: Re: [PATCH v2] erofs-utils: get block device size correctly
Message-ID: <20190808032024.GA48434@138>
References: <1565188615-19591-1-git-send-email-shenmeng999@126.com>
 <20190807182644.GA13848@hsiangkao-HP-ZHAN-66-Pro-G1>
 <e551209.248f.16c6f227220.Coremail.shenmeng999@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e551209.248f.16c6f227220.Coremail.shenmeng999@126.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 08, 2019 at 10:50:24AM +0800, shenmeng999 wrote:
> Hi hsiangkao:
>     I agree with your modification.It's getting better.Thanks!

OK, Let me update it to dev branch as well this evening :)

Thanks,
Gao Xiang

> 
> 
> At 2019-08-08 02:26:50, "Gao Xiang" <hsiangkao@aol.com>, said: 
> >Hi shenmeng,
> >
> >On Wed, Aug 07, 2019 at 10:36:55PM +0800, shenmeng999@126.com wrote:
> >> From: shenmeng996 <shenmeng999@126.com>
> >> 
> >> fstat return block device's size of zero.
> >> use ioctl to get block device's size.
> >> 
> >> Signed-off-by: shenmeng996 <shenmeng999@126.com>
> >
> >
> >Thanks for your patch v2 :)
> >
> >It looks good to me, and I update this patch so that
> >autoconf can check these new header files.
> >https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental&id=0f225449962b4a9716985e7530a395a9500d0de6
> >Do you agree with this modification? please share your thought about this.
> >
> >Thanks,
> >Gao Xiang
> >
> >diff --git a/configure.ac b/configure.ac
> >index 6f4eacc..fcdf30a 100644
> >--- a/configure.ac
> >+++ b/configure.ac
> >@@ -73,12 +73,14 @@ AC_CHECK_HEADERS(m4_flatten([
> > 	fcntl.h
> > 	inttypes.h
> > 	linux/falloc.h
> >+	linux/fs.h
> > 	linux/types.h
> > 	limits.h
> > 	stddef.h
> > 	stdint.h
> > 	stdlib.h
> > 	string.h
> >+	sys/ioctl.h
> > 	sys/stat.h
> > 	sys/time.h
> > 	unistd.h
> >diff --git a/lib/io.c b/lib/io.c
> >index 93328d3..15c5a35 100644
> >--- a/lib/io.c
> >+++ b/lib/io.c
> >@@ -9,7 +9,11 @@
> > #define _LARGEFILE64_SOURCE
> > #define _GNU_SOURCE
> > #include <sys/stat.h>
> >+#include <sys/ioctl.h>
> > #include "erofs/io.h"
> >+#ifdef HAVE_LINUX_FS_H
> >+#include <linux/fs.h>
> >+#endif
> > #ifdef HAVE_LINUX_FALLOC_H
> > #include <linux/falloc.h>
> > #endif
> >@@ -21,6 +25,26 @@ static const char *erofs_devname;
> > static int erofs_devfd = -1;
> > static u64 erofs_devsz;
> > 
> >+int dev_get_blkdev_size(int fd, u64 *bytes)
> >+{
> >+	errno = ENOTSUP;
> >+#ifdef BLKGETSIZE64
> >+	if (ioctl(fd, BLKGETSIZE64, bytes) >= 0)
> >+		return 0;
> >+#endif
> >+
> >+#ifdef BLKGETSIZE
> >+	{
> >+		unsigned long size;
> >+		if (ioctl(fd, BLKGETSIZE, &size) >= 0) {
> >+			*bytes = ((u64)size << 9);
> >+			return 0;
> >+		}
> >+	}
> >+#endif
> >+	return -errno;
> >+}
> >+
> > void dev_close(void)
> > {
> > 	close(erofs_devfd);
> >@@ -49,7 +73,12 @@ int dev_open(const char *dev)
> > 
> > 	switch (st.st_mode & S_IFMT) {
> > 	case S_IFBLK:
> >-		erofs_devsz = st.st_size;
> >+		ret = dev_get_blkdev_size(fd, &erofs_devsz);
> >+		if (ret) {
> >+			erofs_err("failed to get block device size(%s).", dev);
> >+			close(fd);
> >+			return ret;
> >+		}
> > 		break;
> > 	case S_IFREG:
> > 		ret = ftruncate(fd, 0);
> >-- 
> >2.17.1
