Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F41FD211
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2019 01:47:41 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Dfp23fK6zF5ZC
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2019 11:47:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573778858;
	bh=PJLA7pws8+1e/CHyr87bc8Bif6B46ZSVyLyCf0IadMs=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=COchkeSQGwyLP/jCjP0scza2dvQg/xr+D14JvgtbmYlcFAgHmOmFuayEYMmISh6L1
	 +K+lI8A/fTBBYVTLOS/P3rLP1NyoU9wZ4pyNZQreyXmWEzdz6CowOK56nhjfIDmu8B
	 +kh+kCKiyEaaH16OhESDe3n6BGBvucyecbSI1SdWqCAkCFn8ETR4G5qqhf9F1IK7n5
	 knEd+7egPmWGFDxBtPxl9VsgBSMpPA4QBcoIqpGAubPx5vPlcsRPh8o6qJi1JN0+q4
	 D/Ljdt3uMzdy6BzIRFV4BAR0auoYsSJSqEYmmQq0TXQeFGSJ8V2uDa7JM09ykd4iDu
	 lpwcLjW5YOROw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.110; helo=sonic313-47.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="isNQqD3d"; 
 dkim-atps=neutral
Received: from sonic313-47.consmr.mail.gq1.yahoo.com
 (sonic313-47.consmr.mail.gq1.yahoo.com [98.137.65.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Dfnq4KMFzF4vb
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2019 11:47:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573778841; bh=a2y6jqLkUnatK91iLJlFJjpg3LEEcm5VqjpkZAkzkDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=isNQqD3d/5HQx75lNyGUukVpaRxF7b8Lsf7Rh4pZqqVzACMQKnQ+Zjwers9OUrsOSGm/RUKTaetXFKqGSPcyQ8rF5+lq6Nq8Md4NPsiVJbDNnU6F7MBB7iP9sFQW1bJig59Fb0Q+nQ2Ky2NL0FAHAv6fi3RGeZSVzkONTg9sHsTCR9oBemGpxtk6bhl5I18y7Sii3NX1YebgwkxPS7otAdr0Inigggf242GGJ4obLEgUssjiHbYSgZjs9JL3jji4S1B58qoFcbLwhxX9aFLhr6n1ND6ax206rBvSnHZvypKf+2zcT7rXjNt8Q5btaCc8nOOfTmSm7dtHd0Y+WQGo1w==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 15 Nov 2019 00:47:21 +0000
Received: by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 234bd9b13aa8560229bdcd951a34976d; 
 Fri, 15 Nov 2019 00:45:19 +0000 (UTC)
Date: Fri, 15 Nov 2019 08:45:14 +0800
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20191115004512.GA7969@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191114190848.f6tlqpnybagez76g@kili.mountain>
 <20191114220015.GA20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114220015.GA20752@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
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
Cc: linux-fsdevel@vger.kernel.org, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan and Matthew,

On Thu, Nov 14, 2019 at 02:00:15PM -0800, Matthew Wilcox wrote:
> On Thu, Nov 14, 2019 at 10:10:03PM +0300, Dan Carpenter wrote:
> > 	fs/erofs/zdata.c:443 z_erofs_register_collection()
> > 	error: double unlocked 'cl->lock' (orig line 439)
> > 
> > fs/erofs/zdata.c
> >    432          cl = z_erofs_primarycollection(pcl);
> >    433          cl->pageofs = map->m_la & ~PAGE_MASK;
> >    434  
> >    435          /*
> >    436           * lock all primary followed works before visible to others
> >    437           * and mutex_trylock *never* fails for a new pcluster.
> >    438           */
> >    439          mutex_trylock(&cl->lock);
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^
> >    440  
> >    441          err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
> >    442          if (err) {
> >    443                  mutex_unlock(&cl->lock);
> >                         ^^^^^^^^^^^^^^^^^^^^^^^
> > How can we unlock if we don't know that the trylock succeeded?
> 
> The comment says it'll always succeed.  That said, this is an uncommon
> pattern -- usually we just mutex_lock().  If there's a good reason to use
> mutex_trylock() instead, then I'd prefer it to be guarded with a BUG_ON.
>

I think there is no actual problem here. If I am wrong, please kindly point out.
The selected code snippet is too short. The current full code is

static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
					     struct inode *inode,
					     struct erofs_map_blocks *map)
{
	struct z_erofs_pcluster *pcl;
	struct z_erofs_collection *cl;
	int err;

	/* no available workgroup, let's allocate one */
	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
	if (!pcl)
		return ERR_PTR(-ENOMEM);

^ Note that this is a new object here, which is guaranteed that the lock
was always unlocked with the last free (and it firstly inited in init_once).

	z_erofs_pcluster_init_always(pcl);

	pcl->obj.index = map->m_pa >> PAGE_SHIFT;

	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);

	if (map->m_flags & EROFS_MAP_ZIPPED)
		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
	else
		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;

	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
	pcl->clusterbits -= PAGE_SHIFT;

	/* new pclusters should be claimed as type 1, primary and followed */
	pcl->next = clt->owned_head;
	clt->mode = COLLECT_PRIMARY_FOLLOWED;

	cl = z_erofs_primarycollection(pcl);
	cl->pageofs = map->m_la & ~PAGE_MASK;

	/*
	 * lock all primary followed works before visible to others
	 * and mutex_trylock *never* fails for a new pcluster.
	 */
	mutex_trylock(&cl->lock);

^ That was simply once guarded by BUG_ON, but checkpatch.pl raised a warning,
I can use DBG_BUGON here instead.

	err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
	if (err) {
		mutex_unlock(&cl->lock);

^ free with unlock as a convention as one example above.

		kmem_cache_free(pcluster_cachep, pcl);
		return ERR_PTR(-EAGAIN);
	}

Thanks,
Gao Xiang

