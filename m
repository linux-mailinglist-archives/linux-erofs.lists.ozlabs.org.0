Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F06D8B26
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 01:38:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsLfQ15wgz3f4j
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 09:38:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1680737886;
	bh=KeGD4MyOApqEcxE+Vz2Xa5S1sUVL6ion9IBrFVNam5c=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=O7Vgr/z9xBbhs66EjYcwg3QAQ0mxlN6G+mYevb0PvzP/tTo247gUNHHHo1wFdTngQ
	 B2VgOwu5BVnqyqYbQzqdmeMA9QqhFbkvdBhv8spbR+uFZay1MF2qe622uvC5EmWn5+
	 rWhxwwz9quWf9DD0tHe+Nr6tiRo5daBVpK4yxm0bUJkeCTPpvDxQn8aBbrBBenDxzx
	 KlkyAVaHDza4vC/GXCNLqTU/fuHpFxe31NDhwmqGyQgPvlkAvHyX5dDZutZugC1qqj
	 qU6zF/10QOlLihJIQjDtdbskG/QsEOuqcD8LZi4ZSNgll0rxPP8KsgsDg3xfb3GZ1c
	 BUJW4omOTkKnw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=david@fromorbit.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20210112.gappssmtp.com header.i=@fromorbit-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=D9eCnKz/;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsLfK1X8gz3cLT
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 09:38:00 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id o2so35916655plg.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 16:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680737878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeGD4MyOApqEcxE+Vz2Xa5S1sUVL6ion9IBrFVNam5c=;
        b=yOUyUnRsJKKAhj7KzWBhGRbQ3ZC3aqv5ck9wZPHGbsHkZXxhHXcfkGU5Lxw0sC67uv
         /gkschKwPaGQkSjMeV+YBIhFzJWV0dhtngY+4mW0vcjs4HMEcs4vrYOUi8dMR+MRTXwV
         iaSDEyyJcTDtI1tCby0ZPBI+CzGix3bvvLpNIMkPWl84z8eVyVhkdouRkvmjEDM+gTzY
         /sChIDqV9I/tC3puAkO2Qt/+W8Jj1btY1DPaiV3HlaLIovO9cVl+6mQGKbozeZkiKle3
         flxO2SC5Vn67MleJbPHxG3r4T24kMAcuTCvZHm/K1SZRHy8rxjWJzb/V0mSpowLEelFH
         WO9Q==
X-Gm-Message-State: AAQBX9c3D/xcw/HuM2w4RsMfOpXgjokk5IxsoXdJ3/iQ8cerhQBnm1E7
	6MrHqKVJ1Z4dIUxbrHJrIcwgpQ==
X-Google-Smtp-Source: AKy350YPpczm2kLshRHm378imxeqOrGuMhMZKLP5TqBhKu/vDXjqcxQbAmKQSkLGeQMyYt/kagueXA==
X-Received: by 2002:a05:6a20:bc96:b0:d9:18ab:16be with SMTP id fx22-20020a056a20bc9600b000d918ab16bemr883843pzb.29.1680737878121;
        Wed, 05 Apr 2023 16:37:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id m37-20020a635825000000b00502dc899394sm9641716pgb.66.2023.04.05.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:37:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pkChN-00HVv9-Mh; Thu, 06 Apr 2023 09:37:53 +1000
Date: Thu, 6 Apr 2023 09:37:53 +1000
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405233753.GU3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
 <ZC38DkQVPZBuZCZN@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC38DkQVPZBuZCZN@gmail.com>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 10:54:06PM +0000, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 08:26:46AM +1000, Dave Chinner wrote:
> > > We could certainly think about moving to a design where fs/verity/ asks the
> > > filesystem to just *read* a Merkle tree block, without adding it to a cache, and
> > > then fs/verity/ implements the caching itself.  That would require some large
> > > changes to each filesystem, though, unless we were to double-cache the Merkle
> > > tree blocks which would be inefficient.
> > 
> > No, that's unnecessary.
> > 
> > All we need if for fsverity to require filesystems to pass it byte
> > addressable data buffers that are externally reference counted. The
> > filesystem can take a page reference before mapping the page and
> > passing the kaddr to fsverity, then unmap and drop the reference
> > when the merkle tree walk is done as per Andrey's new drop callout.
> > 
> > fsverity doesn't need to care what the buffer is made from, how it
> > is cached, what it's life cycle is, etc. The caching mechanism and
> > reference counting is entirely controlled by the filesystem callout
> > implementations, and fsverity only needs to deal with memory buffers
> > that are guaranteed to live for the entire walk of the merkle
> > tree....
> 
> Sure.  Just a couple notes:
> 
> First, fs/verity/ does still need to be able to tell whether the buffer is newly
> instantiated or not.

Boolean flag from the caller.

> Second, fs/verity/ uses the ahash API to do the hashing.  ahash is a
> scatterlist-based API.  Virtual addresses can still be used (see sg_set_buf()),
> but the memory cannot be vmalloc'ed memory, since virt_to_page() needs to work.
> Does XFS use vmalloc'ed memory for these buffers?

Not vmalloc'ed, but vmapped. we allocate the pages individually, but
then call vm_map_page() to present the higher level code with a
single contiguous memory range if it is a multi-page buffer.

We do have the backing info held in the buffer, and that's what we
use for IO. If fsverity needs a page based scatter/gather list
for hardware offload, it could ask the filesystem to provide it
for that given buffer...

> BTW, converting fs/verity/ from ahash to shash is an option; I've really never
> been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
> this, though, would be that it would remove support for all the hardware crypto
> drivers.
>
> That *might* actually be okay, as that approach to crypto acceleration
> has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
> worry about e.g. someone coming out of the woodwork and saying they need to use
> fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
> they MUST use their crypto accelerator to get acceptable performance.

True, but we are very unlikely to be using XFS on such small
systems and I don't think we really care about XFS performance on
android sized systems, either.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
