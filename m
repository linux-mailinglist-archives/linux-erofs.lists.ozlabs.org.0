Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C83828C24
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 19:11:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8fBj2LDTz3bTn
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 05:11:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8fBc4p86z30Qk
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 05:11:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W-JAUV5_1704823869;
Received: from 30.25.253.88(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-JAUV5_1704823869)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 02:11:12 +0800
Message-ID: <97d0e776-d672-405a-9359-fb7f16969dc3@linux.alibaba.com>
Date: Wed, 10 Jan 2024 02:11:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] erofs: Don't use certain internal folio_*() functions
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>
References: <20240109180117.1669008-1-dhowells@redhat.com>
 <20240109180117.1669008-4-dhowells@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240109180117.1669008-4-dhowells@redhat.com>
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
Cc: linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Yue Hu <huyue2@coolpad.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/1/10 02:01, David Howells wrote:
> Filesystems should not be using folio->index not folio_index(folio) and
> folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
> code.
> 
> Change this automagically with:
> 
> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: Yue Hu <huyue2@coolpad.com>
> cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org

Thank you, David!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(I've asked Jingbo to find some free slot to refine
  this part for later compressed data adaption.  Yet that
  is another separate story.  The patch looks good to me.)

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 87ff35bff8d5..bc12030393b2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -165,10 +165,10 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>   static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   {
>   	int ret;
> -	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
> +	struct erofs_fscache *ctx = folio->mapping->host->i_private;
>   	struct erofs_fscache_request *req;
>   
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>   				folio_pos(folio), folio_size(folio));
>   	if (IS_ERR(req)) {
>   		folio_unlock(folio);
> @@ -276,7 +276,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>   	struct erofs_fscache_request *req;
>   	int ret;
>   
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>   			folio_pos(folio), folio_size(folio));
>   	if (IS_ERR(req)) {
>   		folio_unlock(folio);
> 
