Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF481604F6E
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 20:17:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MszTd3gFmz3c7B
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 05:17:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=he9NpC2b;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=fmdefrancesco@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=he9NpC2b;
	dkim-atps=neutral
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MszTS6H2wz2xJ7
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 05:16:58 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so606837wmb.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhFpcNLAWcGDCBo0K7yVdazuvwSnNgkUZyErY0NIE1c=;
        b=he9NpC2bg44o27n2ccTQZQQa6V/ilBK8VkwzBsH3BoGDoFiZKIv7zwtKQzzyIFV3EQ
         ls313Q9MIR/eh6dOGpzb8ElOHrrbHfA8jWvYpl7fGmMNCDfbrZRwJPAjafyt8Cvv8Jbi
         BTZoIqAu5mL+9x54oVByaOyHX2gVN8T6xwjiDBsBVablPuWruvCzwIF8aSN8AVEJKdec
         iDAE7XjJozmp8irP9D0fQRsrAbpNKlD8yzcShaNmQ+FT0fmTl2HF/SB9h7bq4E8J5wcM
         OyF4m1sr2tatMgN5g6MaiCQBLxUrGrj4ZpJxd3EL1uBVfNLVlPxWCwxzCqSYJkjcXFF0
         tgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhFpcNLAWcGDCBo0K7yVdazuvwSnNgkUZyErY0NIE1c=;
        b=u692JNsL6+Vvbg13aFBhwl80E4Yp3WfbEL/mLQzOsrglH7W5nKfEe528k9h3ZSplSp
         UeDNl0nW/AaJuuq85Mhe+oYDeXF/KMC5Nu4j3sV3WA/NyKQxeeUxKpWir5KD84xPjzpw
         Z+X7fjEGqcXSiUOxepLS3RonK2jr6CEjW3dL/VIwCZy/WQB0g2FApmcD80YQyrsjv8VZ
         H5p/wwETSF/3muKemF2jLvOgZ6+seC4TUt0OKrD2zZ0v0FO29GnUSwPlleTic5RQl41K
         D3PhpKgbeurECUaHffpLUge2Q0ePsa2j36OQHyKqsXj9eT/P7pT2TekvzrCOZupaSIK0
         kohg==
X-Gm-Message-State: ACrzQf3mzEbk/2fMlgDAxN5nMTGme5BDL9Z8xL5Kl4Oe4iHLjSAveer4
	baqIqfVwWoFbGLUEGGOUKHE=
X-Google-Smtp-Source: AMsMyM60hSkepDp4MHgqGpWApnFiMjPz5F65vp8JEYVikCB4i2VdBy40K2G7DQqVUYnSDJwVMFHEow==
X-Received: by 2002:a05:600c:4fd4:b0:3c6:fb81:ab3c with SMTP id o20-20020a05600c4fd400b003c6fb81ab3cmr6991132wmq.160.1666203412456;
        Wed, 19 Oct 2022 11:16:52 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c438700b003b4c979e6bcsm623420wmn.10.2022.10.19.11.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:16:51 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date: Wed, 19 Oct 2022 20:17:05 +0200
Message-ID: <12077010.O9o76ZdvQC@mypc>
In-Reply-To: <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com> <2019477.yKVeVyVuyW@mypc> <Y084l0m88JGOqGRN@B-P7TQMD6M-0146.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: ira.weiny@intel.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wednesday, October 19, 2022 1:36:55 AM CEST Gao Xiang wrote:
> On Wed, Oct 19, 2022 at 01:21:27AM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, October 18, 2022 11:29:21 PM CEST Gao Xiang wrote:
> 
> ...
> 
> > 
> > > One of what I need to care is nested kmap() usage,
> > > some unmap/remap order cannot be simply converted to kmap_local()
> > 
> > Correct about nesting. If we map A and then B, we must unmap B and then A.
> > 
> > However, as you seem to convey, not always unmappings in right order 
(stack 
> > based) is possible, sometimes because very long functions have many loop's 
> > breaks and many goto exit labels.
> > 
> > > but I think
> > > it's not the case for erofs_bread().  Actually EROFS has one of such 
nested
> > > kmap() usage, but I don't really care its performance on HIGHMEM 
platforms,
> > > so I think kmap() is still somewhat useful compared to kmap_local() from 
> > this
> > > point of view],
> > 

fs/erofs conversions are in our (Ira's and my) list. So I'm am happy to see 
that we can delete some entries because of your changes. :-)

> > In Btrfs I solved (thanks to David S.' advice) by mapping only one of two 
> > pages, only the one coming from the page cache. 
> > 
> > The other page didn't need the use of kmap_local_page() because it was 
> > allocated in the filesystem with "alloc_page(GFP_NOFS)". GFP_NOFS won't 
ever 
> > allocate from ZONE_HIGHMEM, therefore a direct page_address() could avoid 
the 
> > mapping and the nesting issues.
> > 
> > Did you check if you may solve the same way? 
> 
> That is not simple.  Currently we have compressed pages and decompressed
> pages (page cache or others), and they can be unmapped when either data
> is all consumed, so compressed pages can be unmapped first, or
> decompressed pages can be unmapped first.  That quite depends on which
> pages goes first.
> 
> I think such usage is a quite common pattern for decoder or encoder,
> you could take a look at z_erofs_lzma_decompress() in
> fs/erofs/decompressor_lzma.c.  

I haven't yet read that code, however I may attempt to propose a pattern for 
solving this kinds of issue, I mean where you don't know which page got mapped 
last...

It's not elegant but it may work. You have compressed and decompressed pages 
and you can't know in advance what page should be unmapped first because you 
can't know in which order they where mapped, right?

I'd use a variable to save two different values, each representing the last 
page mapped. When the code gets to the unmapping block (perhaps in an "out" 
label), just check what that variable contains. Depending on that value, say 
'c' or 'd', you will be able to know what must be unmapped for first. An "if / 
else" can do the work.

What do you think of this?

> So kmap() is still useful for such cases
> since I don't really care the HIGHMEM performance but correctness, but
> other alternative could churn/complex the map/unmap/remap pattern.

Sooner or later someone will have to address this issue and remove those 
kmap() call sites. We are working on this and hope to always figure out a way 
to work it out. 

I hope that what I wrote above may help, although I'm writing on a purely 
theoretically bases, since, as said, I haven't yet seen that code.

If due to my poor English I've not been able to convey my thoughts please let 
me know, so that I'll try to reword.

Thanks,

Fabio

> Thanks,
> Gao Xiang
> 
> > 
> > A little group of people are working to remove all kmap() and 
kmap_atomic() we 
> > meet across the whole kernel. I have not yet encountered conversions which 
> > cannot be made. Sometimes we may refactor, if what I said above cannot 
apply.
> > 
> > > but in order to make it all work properly, I will try to do
> > > stress test with 32-bit platform later. 
> > 
> > I use QEMU/KVM x86_32 VM, 6GB RAM, and a kernel with HIGHMEM64G enabled 
and an 
> > openSUSE Tumbleweed 32 distro. I've heard that Debian too provides an 
x86_32 
> > distribution. 
> > 
> > > Since it targets for the next cycle
> > > 6.2, I will do a full stress test in the next following weeks.
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > 
> > Thanks,
> > 
> > Fabio
> > 
> 



