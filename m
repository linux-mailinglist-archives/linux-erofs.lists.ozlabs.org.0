Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE469483EAE
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 10:02:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSmpp5mC4z3bjT
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 20:02:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSmpZ5B8gz3017
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jan 2022 20:02:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0us7pN_1641286921; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0us7pN_1641286921) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 04 Jan 2022 17:02:02 +0800
Date: Tue, 4 Jan 2022 17:02:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 5/5] erofs: use meta buffers for zmap operations
Message-ID: <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-6-hsiangkao@linux.alibaba.com>
 <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, Jan 04, 2022 at 04:15:05PM +0800, Chao Yu wrote:
> On 2022/1/2 12:00, Gao Xiang wrote:

...

> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -698,20 +698,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >   		goto err_out;
> >   	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> > -		struct page *mpage;
> > +		void *mp;
> > -		mpage = erofs_get_meta_page(inode->i_sb,
> > -					    erofs_blknr(map->m_pa));
> > -		if (IS_ERR(mpage)) {
> > -			err = PTR_ERR(mpage);
> > +		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> > +					erofs_blknr(map->m_pa), EROFS_NO_KMAP);
> > +		if (IS_ERR(mp)) {
> > +			err = PTR_ERR(mp);
> >   			erofs_err(inode->i_sb,
> >   				  "failed to get inline page, err %d", err);
> >   			goto err_out;
> >   		}
> > -		/* TODO: new subpage feature will get rid of it */
> > -		unlock_page(mpage);
> > -
> > -		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> > +		get_page(fe->map.buf.page);
> 
> Comparing to previous implementation, it adds an extra reference on the page, why?

Thanks for the question. Previously, erofs_get_meta_page was called
independently without reusing zmap mpage, so the page refcount had no
relationship with zmap mpage.

However, now we reuse zmap metabuf instead(fe->map.buf), so an extra
page refcount is needed since zmap metabuf will be released at the end
of readpage or readahead...

Thanks,
Gao Xiang
