Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B0896F0B
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 14:41:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V8krv34ppz3vs6
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Apr 2024 23:41:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V8krq5SnSz3vps
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Apr 2024 23:41:31 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B14568BFE; Wed,  3 Apr 2024 14:41:25 +0200 (CEST)
Date: Wed, 3 Apr 2024 14:41:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Message-ID: <20240403124124.GA19085@lst.de>
References: <20240403101422.GA7285@lst.de> <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com> <3235934.1712139047@warthog.procyon.org.uk> <3300438.1712141700@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3300438.1712141700@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 03, 2024 at 11:55:00AM +0100, David Howells wrote:
> So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just send a
> patch replace all of them with EXPORT_SYMBOL_GPL()?

No my business.  But if you want to side track this let me just put this
in here:

NAK to the non-GPL EXPORT of writeback_iter().

