Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDA163AEC
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 04:16:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MjYY38ybzDqfK
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 14:16:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mail105.syd.optusnet.com.au (client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by lists.ozlabs.org (Postfix) with ESMTP id 48MjYT4rpNzDqXT
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 14:16:28 +1100 (AEDT)
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0C8703A2239;
 Wed, 19 Feb 2020 14:16:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4Fqc-0005MI-Kp; Wed, 19 Feb 2020 14:16:26 +1100
Date: Wed, 19 Feb 2020 14:16:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 14/19] ext4: Convert from readpages to readahead
Message-ID: <20200219031626.GC10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-25-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=gdF_tSV0u4M_20XL-lkA:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
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

On Mon, Feb 17, 2020 at 10:46:05AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in ext4
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

There's nothing I can see in this that would cause that list
corruption I saw with ext4.

I'll re-introduce the patch and see if it falls over again.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
