Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E0D79FD72
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 09:49:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmTxW2N8zz3dHF
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 17:49:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmTxS2XtDz3cGq
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 17:49:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs1V.TH_1694677779;
Received: from 30.97.48.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs1V.TH_1694677779)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 15:49:39 +0800
Message-ID: <ec2ebae2-200d-6f9c-6989-4c889beb5cbd@linux.alibaba.com>
Date: Thu, 14 Sep 2023 15:49:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v8 7/8] erofs-utils: mkfs: introduce rebuild mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230913120304.15741-1-jefflexu@linux.alibaba.com>
 <20230913120304.15741-8-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230913120304.15741-8-jefflexu@linux.alibaba.com>
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



On 2023/9/13 20:03, Jingbo Xu wrote:
> Introduce a new EXPERIMENTAL rebuild mode, which can be used to
> generate a meta-only multidev manifest image with an overlayfs-like
> merged tree from multiple specific EROFS images either of
> 
> tarerofs index mode (--tar=i):
> 
>    mkfs.erofs --tar=i --aufs layer0.erofs layer0.tar
>    ...
>    mkfs.erofs --tar=i --aufs layerN.erofs layerN-1.tar
> 
> or mkfs.erofs uncompressed mode without inline data:
> 
>    mkfs.erofs --tar=f -Enoinline_data --aufs layer0.erofs layer0.tar
>    ...
>    mkfs.erofs --tar=f -Enoinline_data --aufs layerN-1.erofs layerN-1.tar
> 
> To merge these layers, just type:
>    mkfs.erofs merged.erofs layer0.erofs ... layerN-1.erofs
> 
> It doesn't support compression and/or flat inline datalayout yet.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

As Jingbo reported, applying the following diff to fix the device table:

diff --git a/mkfs/main.c b/mkfs/main.c
index 389bb1b..c5dda66 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -590,10 +590,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
  
  		if (rebuild_mode) {
  			char *srcpath = cfg.c_src_path;
+			struct erofs_sb_info *src;
  
  			do {
-				struct erofs_sb_info *src;
-
  				src = calloc(1, sizeof(struct erofs_sb_info));
  				if (!src) {
  					erofs_rebuild_cleanup();
@@ -823,7 +822,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
  	struct erofs_sb_info *src;
  	unsigned int extra_devices = 0;
  	erofs_blk_t nblocks;
-	int ret, i = 0;
+	int ret;
  
  	list_for_each_entry(src, &rebuild_src_list, list) {
  		ret = erofs_rebuild_load_tree(root, src);
@@ -853,7 +852,7 @@ static int erofs_rebuild_load_trees(struct erofs_inode *root)
  			nblocks = src->devs[0].blocks;
  		else
  			nblocks = src->primarydevice_blocks;
-		sbi.devs[i++].blocks = nblocks;
+		sbi.devs[src->dev - 1].blocks = nblocks;
  	}
  	return 0;
  }
-- 
2.19.1.6.gb485710b
