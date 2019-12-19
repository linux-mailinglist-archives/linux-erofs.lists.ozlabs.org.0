Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2DB1268D5
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Dec 2019 19:19:32 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47f0X112hczDqsl
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2019 05:19:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1576779569;
	bh=4HdrA1yMXP97LzJ8x0u3PiUyX+tQWIK+zggfdjUHSdc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=h5D8p6hH4fXRXg054l90d0qeeMUoP5uQMeToo2XAEK/OhQzmyZoeAZEejXT9xm5EY
	 JB/n0ZEeFIJxmDnKu6dQ3gipI4CTsQ5Rhtbgem/IA+g6UXC07sN030KMYojt0ePlAg
	 mAghprjOXUAfLX7TFEOTpJuF8pzKUtEblOYzfGQMoYXZbxm9rEnEWShFybduCoNbia
	 ya3vpZdV1/P74JiIZFjYc69xaMrdRkMEMTxOpyQvkdjjWmfqWHCQ+WtR4vLjeypWmS
	 2PL+Z2fgTxN4HUBfvsV2crIuIP2l6OGtEgEZsVn+aLIowsdfjd6NsTwpFX0APefRGq
	 svGl0z/km827A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="bKjwPLVy"; 
 dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47f0Wv2PvxzDqld
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Dec 2019 05:19:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1576779557; bh=AKJL3aZixwndm6U4xV6ByhUcHtPJ3ukkXetzKAJtJYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=bKjwPLVyPeTQki7FUFDejO5HvWuI+zFE1KccTh89dThqq4UDkoBh0zfKGuBN+hAxyTBEO7fc23kMY5GSTXX6FYrjKUR+dMFS3K0meEUsiqMT3RuqmFupCcaZe8AnkCp7l6oTdzSP/qGQqqGqPJk0vxw5vJAQeEeynkjf5EdzXQm2Zm5NT0w0yXuwFK0ZF7SPDiKu/ZgPucWAYLb1rgxvNLpYXTR9YL5PAkZkcESbBstF06QJMniUlmL/OHLGuhAPSzhtCEa7yQ/fo6zK7Mlp+DHAuIgBbE9fdiMaBVmyQvyGt/oizLH7x9n0beO76cst+1DisGa94yT6w53qJ0lHvQ==
X-YMail-OSG: irxLGigVM1mCUPPpt1bJ9nsNi0zBojMJRbY8OnvkUzOXa5yqkLnVe7fvEeR6PS.
 kDRxx5ViqgfEvuOWMW9sAxCxaRK.ZZfY8akFqMl8Yy8yBwxjpFIfFlG1aY.krQm06h7QovM6Kdj2
 rVna2JzmGNZgx_vL77Wf6YUZfZ2jTYE6_H4JPht.mzV5clhipOBMJbZ5JWI7ekMu54E94OBmB2o4
 4nRE3lLq08_2i7h2b.K7A88Y8dj0Y06zVanGz_rRh0R4R4Gj.NImJo16pfkIfq5mENZOl3uGn2TS
 dkgoNykyD5Aq2KZ7o77QGldlAXOxFFUg.4mv0tOep_v0sQXP44u0waF6hmb9XnMUF2DCD6JE7mAN
 2x4F1I30BsIQF8Swn0Ft_hghLOy6HyNkwkldE3VOujCb_hazypTvqwEdYvjwIQDpQSD5_Q1Epnba
 uf8pdr1t_mk8Ucv9CJzWrkI9XjXh.T7Vj_3b0uZzZdtXMr2Ijhnl0iXy8.QRpvFvF94zowjVh.cm
 vT5yDoZd3kVjoolDhe8iuTYBxykDoRd5iNUW3E_ZLJ5n.fnVWoz19hoJD0d1ZwpdiV67blMQH_3c
 JcGcTp9UCPGlfGu0SrNkp__7Ac8Uon0UnYIKLCIEROWs7io66qNd4JHUVzzNJbcxwppoHcdFhgKN
 A5uWeTXENvv2CKXjakToP45FcGVdE9lLAzcZAkj3LEtACbsTuU0bzzdL7SJ1Uq.KHGnIoT8rizAi
 AHtR3eYJqy1u4JfVe5sfRLbu8zfJqFGV.y8TnCNjPQU3y3myBwLWerV3Cf.h.KCkGE2QaOFZlofC
 kGjICe3.aKA.NGnuXOq.PVBIxVzg4KKjhgNf.9YapB_KxiKPcLgNiaPOKBlXUuaY3aeduCpIe.qf
 pElPMU6elx35dBvggGU17fMQ6Lqn2vn.pkPS12yZ6Nr0Hg.m9HySlQfaRq_CmcAx5znMTLchhmvG
 EeduMvLUZyWQ4jhBkH9_Y2Wbp_j9I727gBEmgtc5oSBMB7IZgsto4B7Z7AaSQZhAJOJoiCuXrraj
 yCw1MT3BDjvKolWNBz2DEbd6scwaBbWLbfex2IZaaPVP1WTzRqQLZz9wRM70_wFYGtmynYKSRzrD
 5sCDchN0shdOXu7niZbL1AcC3k6ssp5mLTXC5be.70xfqs5aqmj.7g6ynM1cQB60J.MWWsOgRESQ
 V8KUzqzy2an_crZJRI2SO_M3T.WMSaeXIKcTQXrn0IEgAYHd31NqhrNtvorYuSzNjKR3Rlw.wVN7
 MCazEKtDMCvYzYIQ4L5phs01VBZy8kGINDozcSzdBLqDKbFoCPgOD7PD6MVaXN8rCC6lrAHvBTas
 hSNk.q4D7uXf3ISkUQnpX1a04fefws8vcv3V1VaOwzYtOguGVvGMz5xnb4byhMMzix6lKPZpGUPU
 e
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Thu, 19 Dec 2019 18:19:17 +0000
Received: by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d0c44fe2bd4b1cd4b5d62b2b68ae834f; 
 Thu, 19 Dec 2019 18:19:12 +0000 (UTC)
Date: Fri, 20 Dec 2019 02:19:04 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v1] erofs-utils:code clean of write file
Message-ID: <20191219181901.GA9405@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191218155237.2222-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218155237.2222-1-blucerlee@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

Sorry for some delay, I'm busying in developping new fixed-sized output
LZMA library approach now (I think I'm fully understand LZMA internals,
hopefully in RFC shape and open source a preliminary effective
implementation next month, and I don't want to delay it too longer...)

Some changes are made as below (and a new version at the end of this
message and experimental branch). Comment as well if you have some
other opinions...

p.s. could you take some time looking at the requirement, thanks a lot!
https://lore.kernel.org/r/CAEvUa7=N7qUobof=vwpXF2XfXcW8R67SB3KV1phRN2ZmG23CvQ@mail.gmail.com/

On Wed, Dec 18, 2019 at 11:52:37PM +0800, Li Guifu wrote:
> From: Li Guifu <bluce.liguifu@huawei.com>
> 
> Make a code clean at function erofs_write_file() which
> has multi jump.

I've rewriten the commit message.

> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---
>  lib/inode.c | 63 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 0e19b11..052315a 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -302,22 +302,10 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
>  	return true;
>  }
>  
> -int erofs_write_file(struct erofs_inode *inode)
> +int erofs_write_file_by_fd(int fd, struct erofs_inode *inode)

I've rename the function to write_uncompressed_file_from_fd and
change the variable order.

>  {
> +	int ret;
>  	unsigned int nblocks, i;
> -	int ret, fd;
> -
> -	if (!inode->i_size) {
> -		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> -		return 0;
> -	}
> -
> -	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
> -		ret = erofs_write_compressed_file(inode);
> -
> -		if (!ret || ret != -ENOSPC)
> -			return ret;
> -	}
>  
>  	/* fallback to all data uncompressed */
>  	inode->datalayout = EROFS_INODE_FLAT_INLINE;
> @@ -327,47 +315,58 @@ int erofs_write_file(struct erofs_inode *inode)
>  	if (ret)
>  		return ret;
>  
> -	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> -	if (fd < 0)
> -		return -errno;
> -
>  	for (i = 0; i < nblocks; ++i) {
>  		char buf[EROFS_BLKSIZ];
>  
>  		ret = read(fd, buf, EROFS_BLKSIZ);
> -		if (ret != EROFS_BLKSIZ) {
> -			if (ret < 0)
> -				goto fail;
> -			close(fd);
> -			return -EAGAIN;
> -		}
> +		if (ret != EROFS_BLKSIZ)
> +			return -errno;

I'd suggest the original approach.

Thanks,
Gao Xiang

>  
>  		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
>  		if (ret)
> -			goto fail;
> +			return ret;
>  	}
>  
>  	/* read the tail-end data */
>  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
>  	if (inode->idata_size) {
>  		inode->idata = malloc(inode->idata_size);
> -		if (!inode->idata) {
> -			close(fd);
> +		if (!inode->idata)
>  			return -ENOMEM;
> -		}
>  
>  		ret = read(fd, inode->idata, inode->idata_size);
>  		if (ret < inode->idata_size) {
>  			free(inode->idata);
>  			inode->idata = NULL;
> -			close(fd);
>  			return -EIO;
>  		}
>  	}
> -	close(fd);
> +
>  	return 0;
> -fail:
> -	ret = -errno;
> +}
> +
> +int erofs_write_file(struct erofs_inode *inode)
> +{
> +	int ret, fd;
> +
> +	if (!inode->i_size) {
> +		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> +		return 0;
> +	}
> +
> +	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
> +		ret = erofs_write_compressed_file(inode);
> +
> +		if (!ret || ret != -ENOSPC)
> +			return ret;
> +	}
> +
> +	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> +	if (fd < 0)
> +		return -errno;
> +
> +	ret = erofs_write_file_by_fd(fd, inode);
> +
>  	close(fd);
>  	return ret;
>  }
> -- 
> 2.17.1
> 


From 11302fc4dc5d53a7730405765828a744aee114f6 Mon Sep 17 00:00:00 2001
From: Li Guifu <blucerlee@gmail.com>
Date: Wed, 18 Dec 2019 23:52:37 +0800
Subject: [PATCH] erofs-utils: clean up erofs_write_file()

Introduce write_uncompressed_file_from_fd() to make
error handling path in erofs_write_file() clearer.

Signed-off-by: Li Guifu <blucerlee@gmail.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 lib/inode.c | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0e19b11..bd0652b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -302,24 +302,11 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 	return true;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 {
+	int ret;
 	unsigned int nblocks, i;
-	int ret, fd;
 
-	if (!inode->i_size) {
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-		return 0;
-	}
-
-	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
-		ret = erofs_write_compressed_file(inode);
-
-		if (!ret || ret != -ENOSPC)
-			return ret;
-	}
-
-	/* fallback to all data uncompressed */
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size / EROFS_BLKSIZ;
 
@@ -327,47 +314,60 @@ int erofs_write_file(struct erofs_inode *inode)
 	if (ret)
 		return ret;
 
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0)
-		return -errno;
-
 	for (i = 0; i < nblocks; ++i) {
 		char buf[EROFS_BLKSIZ];
 
 		ret = read(fd, buf, EROFS_BLKSIZ);
 		if (ret != EROFS_BLKSIZ) {
 			if (ret < 0)
-				goto fail;
-			close(fd);
+				return -errno;
 			return -EAGAIN;
 		}
 
 		ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
 		if (ret)
-			goto fail;
+			return ret;
 	}
 
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
-		if (!inode->idata) {
-			close(fd);
+		if (!inode->idata)
 			return -ENOMEM;
-		}
 
 		ret = read(fd, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
 			free(inode->idata);
 			inode->idata = NULL;
-			close(fd);
 			return -EIO;
 		}
 	}
-	close(fd);
 	return 0;
-fail:
-	ret = -errno;
+}
+
+int erofs_write_file(struct erofs_inode *inode)
+{
+	int ret, fd;
+
+	if (!inode->i_size) {
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		return 0;
+	}
+
+	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
+		ret = erofs_write_compressed_file(inode);
+
+		if (!ret || ret != -ENOSPC)
+			return ret;
+	}
+
+	/* fallback to all data uncompressed */
+	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
+	if (fd < 0)
+		return -errno;
+
+	ret = write_uncompressed_file_from_fd(inode, fd);
 	close(fd);
 	return ret;
 }
-- 
2.20.1


