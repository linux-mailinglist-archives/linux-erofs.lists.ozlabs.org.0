Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF93D288E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jul 2021 18:53:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GVz7733wvz3029
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 02:53:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GVz706nWLz2yMg
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jul 2021 02:53:47 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9F5F167373; Thu, 22 Jul 2021 18:53:42 +0200 (CEST)
Date: Thu, 22 Jul 2021 18:53:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <20210722165342.GA11435@lst.de>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de> <20210722165109.GD8639@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722165109.GD8639@magnolia>
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
Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 22, 2021 at 09:51:09AM -0700, Darrick J. Wong wrote:
> The commit message is a little misleading -- this adds support for
> inline data pages at nonzero (but page-aligned) file offsets, not file
> offsets into the page itself.  I suggest:

It actually adds both.  pos is the offset into the file.
