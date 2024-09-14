Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED0978CC2
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 04:24:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X5FNc0FJxz302T
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Sep 2024 12:24:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726280634;
	cv=none; b=Jy29Jq9RwcqXbAsYnElNFXTgzLZJM+3H2RCE81IiuSChiJi2LKOK+4hZxuTnkhGgl7P+snJ/0DNTTceMUToYqe/JKGeMZv6XKaQ3wvsHsETxbOac/VYBOrgwRqysgn9/hq29DURH1XfW17/8mv3UkW4Ht2QRz0GIFjVXOmJqevTZqh5US3P8c5SqZpBqD4Y90DnCO5WvLj5yTJyEYrTjnKDWYn2yLbwTMuHGGvndqvv/0HZXkUhhHZ6EVoETEoSQ1vO2dW5tSyQ82zmAK15ZpI2U3SzuJbbD7n/6zjAxi+Ti3ivVCxP+Dpjr86utSjcOUBUBX5rTLweBrsb1/wiIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726280634; c=relaxed/relaxed;
	bh=pPWvnEC3yapocKdSsGj1HeajnVbM+z8QtaBI2kTZ3lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M4I3bAAJtKL+nTlvST5cKYIDRQUB82QJXtuhobKAGpAJCY+sIKLTN6teAbQfH9HKBMe6p5Ne8gKrA4vQW1jGfKIekRJ7AbGFOIw/czP/zKeVcmdnBMrIsB+Zc7FzD+cofuww9aylpuGiKqHvVLDolaceY1oroKLnrnAfeIzeUvhFKuLiUm+JL7CI3E58kefSAGFfpKKMTOWDm41ok2Rupmjt+jB2BFZuMUosw/5jcASng+m6LegYGf9HLB8wsofdVL/0wADTtw2xcahgXFU6SzL+LiH0thb7pKpXz8K8nLGGfB1CKOQATI7bUyDv/TXdX52hoYpIR8dwaHiJehzu2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KfxcZlzU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KfxcZlzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X5FNT3Brrz2y66
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Sep 2024 12:23:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726280625; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pPWvnEC3yapocKdSsGj1HeajnVbM+z8QtaBI2kTZ3lE=;
	b=KfxcZlzU7CLsRt/fiEuwMpoRjFa3h8pIWz85DlsNNR5NwfhdFF7Fxz2cnqFZn+Sh2qqCkdQ6EZIiCOAER+Rkng8p0egXLJONld+8ZxvHxRlS/MzIQb5vii0dBk4ypLivBnn3bTKdJY9GxSDrbuQgVkMZFquEaEJzTD7p8inJon0=
Received: from 30.221.130.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEwMjoQ_1726280623)
          by smtp.aliyun-inc.com;
          Sat, 14 Sep 2024 10:23:44 +0800
Message-ID: <9a850f23-075a-464d-95ef-d8b62e59cd58@linux.alibaba.com>
Date: Sat, 14 Sep 2024 10:23:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] erofs-utils: fsck: introduce exporting xattrs
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240913072100.577753-1-hongzhen@linux.alibaba.com>
 <20240913072100.577753-2-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240913072100.577753-2-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/13 15:21, Hongzhen Luo wrote:
> Currently `fsck --extract` does not support exporting
> extended attributes. This patch adds the `--xattrs` option
> to dump extended attributes and the `--no-xattrs` option to
> omit them (the default behavior).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---

It fails to build on MacOS, I've applied the following fix manually:

diff --git a/configure.ac b/configure.ac
index 945e254..9c1657b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -260,6 +260,7 @@ AC_CHECK_FUNCS(m4_flatten([
  	gettimeofday
  	lgetxattr
  	llistxattr
+	lsetxattr
  	memset
  	realpath
  	lseek64
diff --git a/fsck/main.c b/fsck/main.c
index b514a63..f20b767 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -470,8 +470,15 @@ static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
  			break;
  		}
  		if (fsckcfg.extract_path)
+#ifdef HAVE_LSETXATTR
  			ret = lsetxattr(fsckcfg.extract_path, key, value, size,
  					0);
+#elif defined(__APPLE__)
+			ret = setxattr(fsckcfg.extract_path, key, value, size,
+				       0, XATTR_NOFOLLOW);
+#else
+			ret = -EOPNOTSUPP;
+#endif
  		else
  			ret = 0;
  		free(value);

Thanks,
Gao Xiang
