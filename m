Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69D2A05BE
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:48:17 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN2Cz2JBpzDqpy
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:48:15 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=I1egCvJw; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1egCvJw; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN2Cn3DXczDqpy
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:48:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604062081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lMNtjlr6gjb2YrjS0I4H09JLNpBeTtIglmY6iniNrA=;
 b=I1egCvJweMI9qv9mvlyGYDoiyhL8H4kRLlbFft7mbbMw8f56b6ftweolI0SP3xxXGYqwCM
 6wJECyqyrVQWgYzGx8rL8V4nc3rvuCVmb80Bqdc/gKuYsqGYSgS/nZC377lGz5sywvz2KF
 iVE0Y7cw/87HgQIb5/394dpq8eC/e6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604062081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lMNtjlr6gjb2YrjS0I4H09JLNpBeTtIglmY6iniNrA=;
 b=I1egCvJweMI9qv9mvlyGYDoiyhL8H4kRLlbFft7mbbMw8f56b6ftweolI0SP3xxXGYqwCM
 6wJECyqyrVQWgYzGx8rL8V4nc3rvuCVmb80Bqdc/gKuYsqGYSgS/nZC377lGz5sywvz2KF
 iVE0Y7cw/87HgQIb5/394dpq8eC/e6Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-kTfUwOWRPUCj0Om4TpP3sA-1; Fri, 30 Oct 2020 08:47:57 -0400
X-MC-Unique: kTfUwOWRPUCj0Om4TpP3sA-1
Received: by mail-pl1-f197.google.com with SMTP id z11so4439230pln.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1lMNtjlr6gjb2YrjS0I4H09JLNpBeTtIglmY6iniNrA=;
 b=bDhN/YY6uAS0uYpKQlWX396G5OVItu+M1ayfzKfq66zLUXj9dPpQ6X750HzJuzkgzG
 qik3khb6Lmn+sG2Nmsed6RabtYk1T7OYD5+p4xzaCKBrEmBTenZqbWNpb/SM0AE0l6Dx
 0KS1mGGU4LBtWeEkv775kovRfOrcu2rqbH5fKc+HrBnAUmnlZqOwLj9HUwsmP22etXB4
 om8lNraWU/SEwPTz+EDknTt+FXGxJ6au9wcsU9nG3cH5HWNNfTvm5gyq9oXiBUo0vKPt
 FC9SFUh5hQUZkXGT3dGnJ8i2LoD+nlAJcXHjsrd3Y2/R0ITL3uzezRplPXTB+Av/szGc
 I6Rw==
X-Gm-Message-State: AOAM530B8jXKvTD9FJXqYZBDKE7ZQYomWPchXD7jfQzb0gLVr/9n0EFw
 2hxA2ii/VTYyRHM6d4HREBSoiSZWdnFaAPeJf19HSBZ/ClzHkG6yKuFEgKdr3ZKjdbFDvsv8zhO
 X+xDeaHrjYg7E/2lRWjtiyhGF
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id
 n3-20020a1709026a83b02900d5e98f2437mr8367914plk.38.1604062076409; 
 Fri, 30 Oct 2020 05:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGsuBRDlsXsTIzJIYaK6ow5wMfYV7EJXHglp/ovpVhBHRB23c3B4lEpVGxAU1cASw4dVCOYQ==
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id
 n3-20020a1709026a83b02900d5e98f2437mr8367895plk.38.1604062076140; 
 Fri, 30 Oct 2020 05:47:56 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o195sm5926051pfg.10.2020.10.30.05.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:47:55 -0700 (PDT)
Date: Fri, 30 Oct 2020 20:47:45 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Vladimir Zapolskiy <vladimir@tuxera.com>
Subject: Re: [PATCH 1/4] erofs: fix setting up pcluster for temporary pages
Message-ID: <20201030124745.GB133455@xiangao.remote.csb>
References: <20201022145724.27284-1-hsiangkao.ref@aol.com>
 <20201022145724.27284-1-hsiangkao@aol.com>
 <ba952daf-c55d-c251-9dfc-3bf199a2d4ff@tuxera.com>
MIME-Version: 1.0
In-Reply-To: <ba952daf-c55d-c251-9dfc-3bf199a2d4ff@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Vladimir,

On Fri, Oct 30, 2020 at 02:20:31PM +0200, Vladimir Zapolskiy wrote:
> Hello Gao Xiang,
> 
> On 10/22/20 5:57 PM, Gao Xiang via Linux-erofs wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > pcluster should be only set up for all managed pages instead of
> > temporary pages. Since it currently uses page->mapping to identify,
> > the impact is minor for now.
> > 
> > Fixes: 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
> > Cc: <stable@vger.kernel.org> # 5.5+
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> 
> I was looking exactly at this problem recently, my change is one-to-one
> to your fix, thus I can provide a tag:
> 
> Tested-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Many thanks for confirming this!
I found this when I was killing magical stagingpage page->mapping,
it's somewhat late :-)

> 
> 
> The fixed problem is minor, but the kernel log becomes polluted, if
> a page allocation debug option is enabled:
> 
>     % md5sum ~/erofs/testfile
>     BUG: Bad page state in process kworker/u9:0  pfn:687de
>     page:0000000057b8bcb4 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x687de
>     flags: 0x4000000000002000(private)
>     raw: 4000000000002000 dead000000000100 dead000000000122 0000000000000000
>     raw: 0000000000000000 ffff888066758690 00000000ffffffff 0000000000000000
>     page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>     Modules linked in:
>     CPU: 1 PID: 602 Comm: kworker/u9:0 Not tainted 5.9.1 #2
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
>     Workqueue: erofs_unzipd z_erofs_decompressqueue_work
>     Call Trace:
>      dump_stack+0x84/0xba
>      bad_page.cold+0xac/0xb1
>      check_free_page_bad+0xb0/0xc0
>      free_pcp_prepare+0x2c8/0x2d0
>      free_unref_page+0x18/0xf0
>      put_pages_list+0x11a/0x120
>      z_erofs_decompressqueue_work+0xc9/0x110
>      ? z_erofs_decompress_pcluster.isra.0+0xf10/0xf10
>      ? read_word_at_a_time+0x12/0x20
>      ? strscpy+0xc7/0x1a0
>      process_one_work+0x30c/0x730
>      worker_thread+0x91/0x640
>      ? __kasan_check_read+0x11/0x20
>      ? rescuer_thread+0x8a0/0x8a0
>      kthread+0x1dd/0x200
>      ? kthread_unpark+0xa0/0xa0
>      ret_from_fork+0x1f/0x30
>     Disabling lock debugging due to kernel taint

Yeah, I can make a pull-request to Linus if you need this to be in master
now, or I can post it for v5.11-rc1 since 5.4 LTS isn't effected (and it
would be only a print problem with debugging option.)

Thanks,
Gao Xiang

> 
> --
> Best wishes,
> Vladimir
> 

