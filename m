Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2436E3D5A59
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 15:30:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYLQG0zF6z307D
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 23:30:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYLQC4fskz303h
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 23:30:11 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 49D6767373; Mon, 26 Jul 2021 15:30:07 +0200 (CEST)
Date: Mon, 26 Jul 2021 15:30:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210726133006.GB6535@lst.de>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <YP6rTi/I3Vd+pbeT@casper.infradead.org>
 <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com>
 <YP60zLP13Hqi5iL+@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP60zLP13Hqi5iL+@B-P7TQMD6M-0146.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 09:12:44PM +0800, Gao Xiang wrote:
> I tend to leave it as another new story and can be resolved with
> another patch to improve it (or I will stuck in this, I need to do
> my own development stuff instead of spinning with this iomap patch
> since I can see this already work well for gfs2 and erofs), I will
> update the patch Andreas posted with Christoph's comments.

Yes, let's do the minimal work for erofs needs in a first step.
After that I hope I can get the iomap_iter change in and then we
can start the next projects.  That being said moving the copy back
to the inline data to writepage does seem very useful, as does the
"small" blocksize support from Matthew.
