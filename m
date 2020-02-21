Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F91681CC
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 16:35:57 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PFsk4p5WzDqkg
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 02:35:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PFsV1sS7zDqf2
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2020 02:35:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+ZsaQJllFuL8jpNObDQrHmpdC/B73n9RqMvE0qPHxaM=; b=e19h/tTJERLUFpOL5Gva3Nh5/X
 wd0VH9aVgKh+1Blgs+9Q15ijaVkaoTLAy7WypYckq6maI2+/Qpa5TYpUzL45zkwW6/rKVd4gOa/Q3
 37XTTlJ3n85F+yMLVB8w0BnbSlS+Y+mVNSOJqRCX3b4kHG/mSGnd+/RHhL7LSbdq0PycpO3gHljyg
 1ePLpWP66QKkQwSW3hqI4AmWyW4KZvprzI+VqeFwh8xfQgZxihaUIj3MuUi6DWndVunwNc8HfQSPa
 cJzgSNpVLmszdlcuXvTGALnsMeU2uXmuwM6kJU9UgfbmbAX46oAsryhNENVSPO0btKS8JfbqGc1YR
 ErE1c+gA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5AL3-00062c-43; Fri, 21 Feb 2020 15:35:37 +0000
Date: Fri, 21 Feb 2020 07:35:37 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v7 11/24] mm: Move end_index check out of readahead loop
Message-ID: <20200221153537.GE24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-12-willy@infradead.org>
 <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ef2075-b849-299e-0f11-c6ee82b0a3c7@nvidia.com>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 07:50:39PM -0800, John Hubbard wrote:
> This tiny patch made me pause, because I wasn't sure at first of the exact
> intent of the lines above. Once I worked it out, it seemed like it might
> be helpful (or overkill??) to add a few hints for the reader, especially since
> there are no hints in the function's (minimal) documentation header. What
> do you think of this?
> 
> 	/*
> 	 * If we can't read *any* pages without going past the inodes's isize
> 	 * limit, give up entirely:
> 	 */
> 	if (index > end_index)
> 		return;
> 
> 	/* Cap nr_to_read, in order to avoid overflowing the ULONG type: */
> 	if (index + nr_to_read < index)
> 		nr_to_read = ULONG_MAX - index + 1;
> 
> 	/* Cap nr_to_read, to avoid reading past the inode's isize limit: */
> 	if (index + nr_to_read >= end_index)
> 		nr_to_read = end_index - index + 1;

A little verbose for my taste ... How about this?

        end_index = (isize - 1) >> PAGE_SHIFT;
        if (index > end_index)
                return;
        /* Avoid wrapping to the beginning of the file */
        if (index + nr_to_read < index)
                nr_to_read = ULONG_MAX - index + 1;
        /* Don't read past the page containing the last byte of the file */
        if (index + nr_to_read >= end_index)
                nr_to_read = end_index - index + 1;

