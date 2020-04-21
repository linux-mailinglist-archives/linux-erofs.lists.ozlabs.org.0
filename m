Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5061B1E43
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2020 07:42:25 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495ssB61NYzDqVN
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2020 15:42:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=ApJOmYR1; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495ss417k1zDqLZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2020 15:42:15 +1000 (AEST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7544A2084D;
 Tue, 21 Apr 2020 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587447732;
 bh=2gulgVkFfAjn3Pl1PNqXRXmkM/QzduOVT11dMu8o86o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ApJOmYR1uYAyNlSBQToll/A86aHlF3kQ/tdWHawXyGpKjOxTqiRWCqHSR3WazJzIA
 4L+nLEixqzeyYNqXfuV8TjK7idDUh5mHndFGgD9WMc/H8gSw+Vy/J9jJ49qwecfb3F
 M7IdSAdFh4D9we0/ZFSI3sw35uAquW5tJmZTokec=
Date: Mon, 20 Apr 2020 22:42:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v11 19/25] erofs: Convert compressed files from
 readpages to readahead
Message-Id: <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
In-Reply-To: <20200414150233.24495-20-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-20-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-xfs@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
 William Kucharski <william.kucharski@oracle.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 14 Apr 2020 08:02:27 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> 
> Use the new readahead operation in erofs.
> 

Well this is exciting.

fs/erofs/data.c: In function erofs_raw_access_readahead:
fs/erofs/data.c:149:18: warning: last_block may be used uninitialized in this function [-Wmaybe-uninitialized]
	*last_block + 1 != current_block) {

It seems to be a preexisting bug, which your patch prompted gcc-7.2.0
to notice.

erofs_read_raw_page() goes in and uses *last_block, but neither of its
callers has initialized it.  Could the erofs maintainers please take a
look?
