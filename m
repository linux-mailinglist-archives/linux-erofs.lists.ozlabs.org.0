Return-Path: <linux-erofs+bounces-1588-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F50CDBA68
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 09:18:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dblC25fv7z2yFY;
	Wed, 24 Dec 2025 19:18:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766564334;
	cv=none; b=GisYlniSMaJbLlEF9fDWWhCvUJxErbbfR9zNg+5U/kNsoND4Sw12LepsYhHYEndroQQZYnrft3Fw8vl/xZ/iH3L0Q9+VTMQHPPzERU+BmorJejTQr9I2JHSSQKqOQ4vMVJiWHSvpIxECiujQTlkQfzsSj+HLeLij0t07nVZ/BGEJ6gErmep2RZ5OMn/1vHXuHhC+BLu72la3YbMufdyFVv7pTJnd2II8/3U50e1QyGe5xxSyuClblojxEjcppkxzC7Bnx8eSro2T2zZ4DLLWLJx4Cdl6s1fX8+yw54xTpBj7j/j1HO8ZGLDe03wTB3xowlk7uHzvy4jpXEsjI423bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766564334; c=relaxed/relaxed;
	bh=vmfl4kJe7qnG1RuxB0cXFeB4KzCnrLvhP6qlpFEYlNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5j8XgxazcRJFbditfFdwuxVGl2l5AWtKpkAg3PrOHKHdcRFogcII0c1Q9559PVN8lOZw1fKRA0TvvMFrGTPkS3E0qlRo8AuN+BYbFsMiz5pGNOtryRaKoPxWKCOj3lrrXraartCYoupkRhRGpT2Ot1GEHq/eC0GD43vOzXW6QPT/cw9NbzAuvF4ZtTAaZ4ijcNw4HL5N/vXxrc9EvKveZzF2SZXf+oSN7eEb53KTbm7/vnBSNvc1yDOE4WAQI9zHE0exWLqJ9X3bz/yxn20MsJi2xA0gkKlpfIJ6JCB8IcghUdW4SSLXxhKm1PCHjAQ0IlFqS/mnsYFnwWaUL6xSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oPvow/Vc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oPvow/Vc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dblC11XCFz2xqm
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 19:18:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564328; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vmfl4kJe7qnG1RuxB0cXFeB4KzCnrLvhP6qlpFEYlNI=;
	b=oPvow/VcpHLGnD56D196UKJraRX7TsnNb2ae0tKttyHcfXd5WT0mUjl5jRWx9w0qh/1xn1ZDVAIsfQNWNGh1QZQsAj9Vl/2JmtVvMH/42SyveaKhRCvKgjbH289+0lf6tLyoN12tmZusQrVM0XfZXTkTMk+Ag2fLpz4dj7syb38=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaaH5I_1766564326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:18:46 +0800
Message-ID: <0185cd6f-791b-41b4-a741-8004a8d43fdf@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:18:45 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/zdata.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 65da21504632..759f3fe225c9 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
>   };
>   
>   struct z_erofs_frontend {
> -	struct inode *const inode;
> +	struct inode *inode;
>   	struct erofs_map_blocks map;
>   	struct z_erofs_bvec_iter biter;
>   
> @@ -1884,9 +1884,13 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
>   static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   {
>   	struct inode *const inode = folio->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
> +	bool need_iput = false;
> +	struct inode *realinode = erofs_real_inode(inode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));

Why not just
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));
?

>   	int err;
>   
> +	DBG_BUGON(!realinode);

Remove this line

> +	f.inode = realinode;
>   	trace_erofs_read_folio(folio, false);
>   	z_erofs_pcluster_readmore(&f, NULL, true);
>   	err = z_erofs_scan_folio(&f, folio, false);
> @@ -1896,23 +1900,30 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   	/* if some pclusters are ready, need submit them anyway */
>   	err = z_erofs_runqueue(&f, 0) ?: err;
>   	if (err && err != -EINTR)
> -		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
> -			  err, folio->index, EROFS_I(inode)->nid);
> +		erofs_err(realinode->i_sb, "read error %d @ %lu of nid %llu",
> +			  err, folio->index, EROFS_I(realinode)->nid);
>   
>   	erofs_put_metabuf(&f.map.buf);
>   	erofs_release_pages(&f.pagepool);
> +
> +	if (need_iput)
> +		iput(realinode);
>   	return err;
>   }
>   
>   static void z_erofs_readahead(struct readahead_control *rac)
>   {
>   	struct inode *const inode = rac->mapping->host;
> -	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
> +	bool need_iput;
> +	struct inode *realinode = erofs_real_inode(inode, &need_iput);
> +	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));

Why not just
	Z_EROFS_DEFINE_FRONTEND(f, realinode, folio_pos(folio));
?

>   	unsigned int nrpages = readahead_count(rac);
>   	struct folio *head = NULL, *folio;
>   	int err;
>   
> -	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
> +	DBG_BUGON(!realinode);

Remove this line.

Thanks,
Gao Xiang

> +	f.inode = realinode;
> +	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
>   	z_erofs_pcluster_readmore(&f, rac, true);
>   	while ((folio = readahead_folio(rac))) {
>   		folio->private = head;
> @@ -1926,8 +1937,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   
>   		err = z_erofs_scan_folio(&f, folio, true);
>   		if (err && err != -EINTR)
> -			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
> -				  folio->index, EROFS_I(inode)->nid);
> +			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
> +				  folio->index, EROFS_I(realinode)->nid);
>   	}
>   	z_erofs_pcluster_readmore(&f, rac, false);
>   	z_erofs_pcluster_end(&f);
> @@ -1935,6 +1946,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	(void)z_erofs_runqueue(&f, nrpages);
>   	erofs_put_metabuf(&f.map.buf);
>   	erofs_release_pages(&f.pagepool);
> +
> +	if (need_iput)
> +		iput(realinode);
>   }
>   
>   const struct address_space_operations z_erofs_aops = {


