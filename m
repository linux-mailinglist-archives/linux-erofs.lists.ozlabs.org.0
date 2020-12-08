Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD02D25E5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 09:29:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqtcq6KvnzDqXD
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 19:28:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ChoAllp3; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ChoAllp3; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqtck3cbHzDqTY
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 19:28:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607416131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TjsxQ2FzOW8Vf+JUFyxyrHDPT5g94+5fVImUHems/bg=;
 b=ChoAllp3IenSpA3t2pK1BrF2q3L9Wkb8XtczRn4PQ0c3ek8cJSLXBTXLm64eq99hD2lHMu
 1aTT215YR2bFyQRdg58tIKTHYoKIwdQF4tc4CtQxOKQZXZkdG/at6Hw5lSpoxD7Y1qsMXo
 YMSYl1/mbHjsWSwhoRIhI9ezZFKphys=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607416131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TjsxQ2FzOW8Vf+JUFyxyrHDPT5g94+5fVImUHems/bg=;
 b=ChoAllp3IenSpA3t2pK1BrF2q3L9Wkb8XtczRn4PQ0c3ek8cJSLXBTXLm64eq99hD2lHMu
 1aTT215YR2bFyQRdg58tIKTHYoKIwdQF4tc4CtQxOKQZXZkdG/at6Hw5lSpoxD7Y1qsMXo
 YMSYl1/mbHjsWSwhoRIhI9ezZFKphys=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-b9odRTeINoW_1kg6liUpMw-1; Tue, 08 Dec 2020 03:28:49 -0500
X-MC-Unique: b9odRTeINoW_1kg6liUpMw-1
Received: by mail-pf1-f199.google.com with SMTP id 193so608235pfz.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 00:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TjsxQ2FzOW8Vf+JUFyxyrHDPT5g94+5fVImUHems/bg=;
 b=TtuTkFLlx0Lv8ihdX1pYqg8HwrBSoEc5GAdLeujVnhDM0qncFpnEW7jF/nWkGa0dpt
 Cm8awiH7FtXVNDAk5hs7oaPsegzhfn4ap5TKS45iCGo92c4WyVCLDGLu2JehxKtLTU0J
 Q5ozq8BDQrD9ihEsRKE4SvEJ3hTzRkV+uozG27zIj9VfXKJ7RkPqADpRu6bA1bbOeazb
 fi1y2d+QqPVsmMW3hvCM97vYq02zsAT9ss/NugJE44KCD0CEgTpdlIwAzlMq0W1d+uhD
 CyOcuSHUmFbU52Blt5dnhjhu2ZHonQAO1mX9wl8YvsFtq8XrQiFZoKhF5pRDiUgvz0Mh
 W2xg==
X-Gm-Message-State: AOAM532XUDgGiMuE6ssh4rBqZtV/POGvZ6nJeC/Fy9rlE5ZuLySRSElK
 K8cL6VdJ8KKtS+FOsAsG4PzPs7XoCQZvOyKaxVz1rn8iJ6D67ik2hBypzO41+2w9zotmkkDTmJw
 pOFl6VEnOYA9k6CkkQsV+I1AH
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id
 g15-20020aa79f0f0000b029019bc68f61cdmr19311539pfr.45.1607416128451; 
 Tue, 08 Dec 2020 00:28:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfxiWJVep27zelwlm4PEke2fzHrgHBaLKKZuL5ZDqWxjwE42PCmN/0sqAxIvpULn5YbI4fZA==
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id
 g15-20020aa79f0f0000b029019bc68f61cdmr19311523pfr.45.1607416128200; 
 Tue, 08 Dec 2020 00:28:48 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f92sm2218853pjk.54.2020.12.08.00.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:28:47 -0800 (PST)
Date: Tue, 8 Dec 2020 16:28:37 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208082837.GC3006985@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
MIME-Version: 1.0
In-Reply-To: <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 08, 2020 at 04:15:59PM +0800, Chao Yu wrote:
> On 2020/12/7 9:23, Gao Xiang wrote:

...


> >   }
> > -static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
> > -					   struct page *page)
> > +static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
> > +					      struct page *page)
> >   {
> > -	if (!z_erofs_page_is_staging(page))
> > +	if (!z_erofs_is_shortlived_page(page))
> >   		return false;
> > -	/* staging pages should not be used by others at the same time */
> > -	if (page_ref_count(page) > 1)
> > +	/* short-lived pages should not be used by others at the same time */
> > +	if (page_ref_count(page) > 1) {
> 
> Does this be a possible case?

Add more words about this.... since EROFS uses rolling decompression (which means
the sliding window is limited (e.g. 64k, but some vendors adjust it to 12k for
example ) even though the uncompressed size is too large (e.g. 128k)), and by
using get_page(), vmap(), and z_erofs_put_shortlivedpage() to free such usage.
Since shortlivedpages won't share with other parallel thread, so it's safe to
just like this to decrease page count (it means how many shared get_page()
before) and recycle to pagepool (on the last reference for later use.)

Thanks,
Gao Xiang

