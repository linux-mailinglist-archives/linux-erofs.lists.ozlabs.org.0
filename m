Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B747680840
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 10:11:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P52Vr1c9Cz3cKv
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 20:11:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P52Vg4bMdz2xVn
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jan 2023 20:11:38 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CF0768BEB; Mon, 30 Jan 2023 10:11:32 +0100 (CET)
Date: Mon, 30 Jan 2023 10:11:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 05/12] erofs: drop posix acl handlers
Message-ID: <20230130091132.GA5178@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org> <20230130064329.GF31145@lst.de> <20230130090008.zg5ddfanrgeommrv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130090008.zg5ddfanrgeommrv@wittgenstein>
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
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 30, 2023 at 10:00:08AM +0100, Christian Brauner wrote:
> > > +	if (xattr_dentry_list(handler, dentry))
> > > +		name = xattr_prefix(handler);
> > 
> > I'm not a huge fan of all this duplicate logic in the file systems
> > that is more verbose and a bit confusing.  Until we remove the
> 
> Yeah, it hasn't been my favorite part about this either.
> But note how the few filesystems that receive that change use the same
> logic by indexing an array and retrieving the handler and then clumsily
> open-coding the same check that is now moved into xattr_dentry_list().

At least it allows for an array lookup.  And of course switching
to xattr_dentry_list instead of open coding it is always a good idea.

> If we want the exact same logic to be followed as today then we need to
> keep the dummy struct posix_acl_{access,default}_xattr_handler around.
> I tried to avoid that for the first version because it felt a bit
> disappointing but we can live with this. This way there's zero code changes
> required for filesystems that use legacy array-based handler-indexing.

Yes, I'd just leave those as-is using the handlers.  I don't really
like the result, but the changes in the series doesn't really look
better and causes extra churn.  In the long run struct xattr_handler
needs to go away and we'll need separate handlers for each type
of xattrs, but that's going to take a while.  Do you know where the
capabilities conversion is standing?

> But we should probably still tweak this so that all these filesystems don't
> open-code the !h || (h->list && !h->list(dentry) check like they do now. So
> something like what I did below at [1]. Thoughts?

Yes, that part is useful.

> +static inline const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)

Overly long line here, though.
