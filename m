Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538AE2A0785
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 15:11:36 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN4426bfDzDqpR
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Oct 2020 01:11:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OorXOklm; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KqYbpE1W; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN4305NDWzDqkf
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Oct 2020 01:10:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE7zJnELOj3JSr2Ymb2+NJIOFKcpsBSnN86Rkhl8axs=;
 b=OorXOklm+xoyx3z3G6aTPyW6vywT119EPPvga/WPSnOeEqFi/5qMYTBguD0AXXUNoUOkMf
 0QVlGsJlTRxk8eE+uq6Y6rRa+JHH0w7Qx9Zs4wirUFNttgRm1pB90IkuTn+M1vOjQBuMvE
 HnKSseRyyU+zDbDgXBj+wwGN5LP7u3g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE7zJnELOj3JSr2Ymb2+NJIOFKcpsBSnN86Rkhl8axs=;
 b=KqYbpE1WsuFBEaQ7EYs1oVX7k/3FCUJntSKJ1OItBTzXdQ+fCZfsqT9PMSd6Gs2leAsIHE
 X/D4deaoO0Eh/YCJ+VTX1uD+QPYKASismptZjQwG1DE/2Z0xwnqusAhqJ6YyXMz1zxXNBN
 eTziQYqYDnn2Fqtvt0Ughs27y3H6DIE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-baLIL7XSNTC6eDpB-1bnkg-1; Fri, 30 Oct 2020 10:10:28 -0400
X-MC-Unique: baLIL7XSNTC6eDpB-1bnkg-1
Received: by mail-pg1-f199.google.com with SMTP id 19so4710154pgq.18
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 07:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oE7zJnELOj3JSr2Ymb2+NJIOFKcpsBSnN86Rkhl8axs=;
 b=nXBIsKUiaPhW6AR3TAJ/tfOMphVbUull5mtfh0jyPwDGXl48OYhi0zopPwZH8qwBaF
 n5K6GxqK0LxlR3ygiAWhOJVbjte3Gkb8kFAXGx6rp6A5NSvZn3K4MaIHQjuuxjK0iCOe
 6nhV6bP8aO6kerwZWGAvRbt+rNuWowKUoCxlOyRN1wLnaTH1BrQQr61Ge20lJQGSluAt
 KK9IL3Pxm5TlKH2xIhDG5abV9sqL9JJUOlq+iC1S7pTvK1jsnGGIxDSVQShzIr6Uufn3
 +QDd8NBcyRce58MqgjE8ODykSF/o6IiNl6B1xiBqEliUrrDpujboFDVRbzQlwY51HGTQ
 rYUw==
X-Gm-Message-State: AOAM5338hdf+gd0kiYS+cUZC9Eqxp3xR+NrrZWBuaNdvnE2YoE6ONtgS
 3UiDpH74ysdoHyN30+rVqL4dLr6xvCSUmTCsYWuO8BQKi357JgkI/+keiDU+csp/czuMvfTGQvQ
 9Xn6KkzQkj/R0G+JrSgj3sjRl
X-Received: by 2002:a17:902:6b84:b029:d5:ef85:1a79 with SMTP id
 p4-20020a1709026b84b02900d5ef851a79mr9345445plk.32.1604067026849; 
 Fri, 30 Oct 2020 07:10:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/z761PmX0cKUlUg1KK66JGCtUiz7/Ov5sHMUFfjPd16VSFCbQsCyxL7bzJDnjhvp8e02ulw==
X-Received: by 2002:a17:902:6b84:b029:d5:ef85:1a79 with SMTP id
 p4-20020a1709026b84b02900d5ef851a79mr9345377plk.32.1604067025973; 
 Fri, 30 Oct 2020 07:10:25 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id mz23sm3376896pjb.3.2020.10.30.07.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:10:25 -0700 (PDT)
Date: Fri, 30 Oct 2020 22:10:15 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Vladimir Zapolskiy <vladimir@tuxera.com>
Subject: Re: [PATCH 1/4] erofs: fix setting up pcluster for temporary pages
Message-ID: <20201030141015.GC133455@xiangao.remote.csb>
References: <20201022145724.27284-1-hsiangkao.ref@aol.com>
 <20201022145724.27284-1-hsiangkao@aol.com>
 <ba952daf-c55d-c251-9dfc-3bf199a2d4ff@tuxera.com>
 <20201030124745.GB133455@xiangao.remote.csb>
 <02427b81-7854-1d97-662f-ab2d2b868514@tuxera.com>
MIME-Version: 1.0
In-Reply-To: <02427b81-7854-1d97-662f-ab2d2b868514@tuxera.com>
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

On Fri, Oct 30, 2020 at 03:32:55PM +0200, Vladimir Zapolskiy wrote:
> Hi Gao Xiang,
> 
> On 10/30/20 2:47 PM, Gao Xiang wrote:
> > Hi Vladimir,
> > 
> > On Fri, Oct 30, 2020 at 02:20:31PM +0200, Vladimir Zapolskiy wrote:
> > > Hello Gao Xiang,
> > > 
> > > On 10/22/20 5:57 PM, Gao Xiang via Linux-erofs wrote:
> > > > From: Gao Xiang <hsiangkao@redhat.com>
> > > > 
> > > > pcluster should be only set up for all managed pages instead of
> > > > temporary pages. Since it currently uses page->mapping to identify,
> > > > the impact is minor for now.
> > > > 
> > > > Fixes: 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
> > > > Cc: <stable@vger.kernel.org> # 5.5+
> > > > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > > 
> > > I was looking exactly at this problem recently, my change is one-to-one
> > > to your fix, thus I can provide a tag:
> > > 
> > > Tested-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> > 
> > Many thanks for confirming this!
> > I found this when I was killing magical stagingpage page->mapping,
> > it's somewhat late :-)
> > 
> 
> sure, for me it was an exciting immersion into the filesystem code :)

Thanks for your effort on this!

You could also post related kernel message in advance and
I will definitly look into that as well. :)

> 
> > > 
> > > 
> > > The fixed problem is minor, but the kernel log becomes polluted, if
> > > a page allocation debug option is enabled:
> > > 
> > >      % md5sum ~/erofs/testfile
> > >      BUG: Bad page state in process kworker/u9:0  pfn:687de
> > >      page:0000000057b8bcb4 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x687de
> > >      flags: 0x4000000000002000(private)
> > >      raw: 4000000000002000 dead000000000100 dead000000000122 0000000000000000
> > >      raw: 0000000000000000 ffff888066758690 00000000ffffffff 0000000000000000
> > >      page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> > >      Modules linked in:
> > >      CPU: 1 PID: 602 Comm: kworker/u9:0 Not tainted 5.9.1 #2
> > >      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> > >      Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> > >      Call Trace:
> > >       dump_stack+0x84/0xba
> > >       bad_page.cold+0xac/0xb1
> > >       check_free_page_bad+0xb0/0xc0
> > >       free_pcp_prepare+0x2c8/0x2d0
> > >       free_unref_page+0x18/0xf0
> > >       put_pages_list+0x11a/0x120
> > >       z_erofs_decompressqueue_work+0xc9/0x110
> > >       ? z_erofs_decompress_pcluster.isra.0+0xf10/0xf10
> > >       ? read_word_at_a_time+0x12/0x20
> > >       ? strscpy+0xc7/0x1a0
> > >       process_one_work+0x30c/0x730
> > >       worker_thread+0x91/0x640
> > >       ? __kasan_check_read+0x11/0x20
> > >       ? rescuer_thread+0x8a0/0x8a0
> > >       kthread+0x1dd/0x200
> > >       ? kthread_unpark+0xa0/0xa0
> > >       ret_from_fork+0x1f/0x30
> > >      Disabling lock debugging due to kernel taint
> > 
> > Yeah, I can make a pull-request to Linus if you need this to be in master
> > now, or I can post it for v5.11-rc1 since 5.4 LTS isn't effected (and it
> > would be only a print problem with debugging option.)
> > 
> 
> As for myself I don't utterly need this fix on the master branch ASAP, however
> it might be reasonable to get it included right into the next v5.10 release,
> because I believe it'll be an LTS. Eventually it's up to you to make a decision,
> from my side I won't urge you, the fixed issue is obviously a non-critical one.
> 
> Thank you for the original fix and taking my opinion into consideration :)

Yeah, v5.10 is a LTS version, and you are right, I will try to make a
pull-request after I get Chao's RVB.

Thanks,
Gao Xiang

> 
> --
> Best wishes,
> Vladimir
> 

