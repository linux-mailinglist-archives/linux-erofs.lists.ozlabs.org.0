Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF1D16AC2E
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2020 17:53:13 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48R7RV36CDzDqWR
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2020 03:53:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2020-01-29 header.b=SBdKy4Pk; 
 dkim-atps=neutral
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48R7RK5yR4zDqTk
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2020 03:53:01 +1100 (AEDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OGXk6G161015;
 Mon, 24 Feb 2020 16:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qQvLoc3+jAuvV02vRfkJ9Yw1PdW1Bn0rhGLTddtKqpU=;
 b=SBdKy4PkCyjA9p4DNjJcshIU3DwIMpNFsdE2tStj9Qp5FXU6ijiLTQcI/7LRWsIjYLHp
 g+0gk8Z5TSTDk2s4zPmxpbnWOQvnveAUuWxvt/Z0AoORrNs51oBxkJVoarDM9RS9uJvV
 vg5W6mivY42ZvhTqMuWEpRFgKI5RbgWnUrrsebAR5s3HuKLknCvQF/jQRGtfR/v4agqY
 xdKIDafPDu/jgv6mKBsTccYFU48Uu8+kPAAP01C1IVt36VjRvxagd24M0Zp/MzxlOE3S
 QPGGuQrkXYxRt1m4fPwQBsQHDD3O0hY7anZZGaWqHkPugsxrYY8jsrzCDvo3W2MQlrRC Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4mwhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 16:52:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OGW70l165513;
 Mon, 24 Feb 2020 16:52:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 2yby5cs488-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Feb 2020 16:52:48 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01OGq2Tj073644;
 Mon, 24 Feb 2020 16:52:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yby5cs464-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 16:52:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OGqjpe019886;
 Mon, 24 Feb 2020 16:52:45 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 08:52:45 -0800
Date: Mon, 24 Feb 2020 08:52:44 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200224165244.GA6731@magnolia>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
 <20200220154912.GC19577@infradead.org>
 <20200220165734.GZ24185@bombadil.infradead.org>
 <20200222010013.GH9506@magnolia>
 <20200224043355.GL24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224043355.GL24185@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240129
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Feb 23, 2020 at 08:33:55PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 21, 2020 at 05:00:13PM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 20, 2020 at 08:57:34AM -0800, Matthew Wilcox wrote:
> > > On Thu, Feb 20, 2020 at 07:49:12AM -0800, Christoph Hellwig wrote:
> > > +/**
> > > + * iomap_readahead - Attempt to read pages from a file.
> > > + * @rac: Describes the pages to be read.
> > > + * @ops: The operations vector for the filesystem.
> > > + *
> > > + * This function is for filesystems to call to implement their readahead
> > > + * address_space operation.
> > > + *
> > > + * Context: The file is pinned by the caller, and the pages to be read are
> > > + * all locked and have an elevated refcount.  This function will unlock
> > > + * the pages (once I/O has completed on them, or I/O has been determined to
> > > + * not be necessary).  It will also decrease the refcount once the pages
> > > + * have been submitted for I/O.  After this point, the page may be removed
> > > + * from the page cache, and should not be referenced.
> > > + */
> > > 
> > > > Isn't the context documentation something that belongs into the aop
> > > > documentation?  I've never really seen the value of duplicating this
> > > > information in method instances, as it is just bound to be out of date
> > > > rather sooner than later.
> > > 
> > > I'm in two minds about it as well.  There's definitely no value in
> > > providing kernel-doc for implementations of a common interface ... so
> > > rather than fixing the nilfs2 kernel-doc, I just deleted it.  But this
> > > isn't just the implementation, like nilfs2_readahead() is, it's a library
> > > function for filesystems to call, so it deserves documentation.  On the
> > > other hand, there's no real thought to this on the part of the filesystem;
> > > the implementation just calls this with the appropriate ops pointer.
> > > 
> > > Then again, I kind of feel like we need more documentation of iomap to
> > > help filesystems convert to using it.  But maybe kernel-doc isn't the
> > > mechanism to provide that.
> > 
> > I think we need more documentation of the parts of iomap where it can
> > call back into the filesystem (looking at you, iomap_dio_ops).
> > 
> > I'm not opposed to letting this comment stay, though I don't see it as
> > all that necessary since iomap_readahead implements a callout that's
> > documented in vfs.rst and is thus subject to all the constraints listed
> > in the (*readahead) documentation.
> 
> Right.  And that's not currently in kernel-doc format, but should be.
> Something for a different patchset, IMO.
> 
> What we need documenting _here_ is the conditions under which the
> iomap_ops are called so the filesystem author doesn't need to piece them
> together from three different places.  Here's what I currently have:
> 
>  * Context: The @ops callbacks may submit I/O (eg to read the addresses of
>  * blocks from disc), and may wait for it.  The caller may be trying to
>  * access a different page, and so sleeping excessively should be avoided.
>  * It may allocate memory, but should avoid large allocations.  This
>  * function is called with memalloc_nofs set, so allocations will not cause
>  * the filesystem to be reentered.

How large? :)

--D
