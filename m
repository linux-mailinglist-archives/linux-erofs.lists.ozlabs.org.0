Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C3768080A
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 10:00:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P52Fg5pdxz3cKb
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 20:00:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tgp2ZBd6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tgp2ZBd6;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P52FZ6lDyz3c4w
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jan 2023 20:00:18 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E6F32B80EB5;
	Mon, 30 Jan 2023 09:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B634C4339B;
	Mon, 30 Jan 2023 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675069213;
	bh=jHP0EhUFW0eb9ggmdYAxVBv8VTlIruuHdNB1/bknF7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgp2ZBd6Aqp1CfwAhmL49v08mNLcZUDbTVhyIihdOFO7TjshuwihX4fhk8WcYwevp
	 E87AHRpj+lxOqj4apgLn9oIywglXm3emg0LNal878GqlSX9tRDyYk1qxbggt8dfJ0a
	 KJ0yZEg6oep02V3VxJ8AlBHBsjvsuUKbARl3iT70ol9LSht+7U/dxEcCqgXDYYWYdO
	 1MP9mMLmhMLta29HOPUExOwQ0rk0jyHBKfrfK1g/0nG9S5u+mCVrhstK6P9mmZ5og8
	 c02CIgYTxIinanVIq2nvyLTFZqEIdUYNGHjpM+6yxWN+Ewrlzo249m9Do9isA3GtDu
	 onsYc/JdlKZJg==
Date: Mon, 30 Jan 2023 10:00:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/12] erofs: drop posix acl handlers
Message-ID: <20230130090008.zg5ddfanrgeommrv@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
 <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
 <20230130064329.GF31145@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130064329.GF31145@lst.de>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 30, 2023 at 07:43:29AM +0100, Christoph Hellwig wrote:
> This review is not for erofs specifically, but for all file systems using
> the same scheme.
> 
> > +static const char *erofs_xattr_prefix(int xattr_index, struct dentry *dentry)
> > +{
> > +	const char *name = NULL;
> > +	const struct xattr_handler *handler = NULL;
> > +
> > +	switch (xattr_index) {
> > +	case EROFS_XATTR_INDEX_USER:
> > +		handler = &erofs_xattr_user_handler;
> > +		break;
> > +	case EROFS_XATTR_INDEX_TRUSTED:
> > +		handler = &erofs_xattr_trusted_handler;
> > +		break;
> > +#ifdef CONFIG_EROFS_FS_SECURITY
> > +	case EROFS_XATTR_INDEX_SECURITY:
> > +		handler = &erofs_xattr_security_handler;
> > +		break;
> > +#endif
> > +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> > +	case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
> > +		if (posix_acl_dentry_list(dentry))
> > +			name = XATTR_NAME_POSIX_ACL_ACCESS;
> > +		break;
> > +	case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
> > +		if (posix_acl_dentry_list(dentry))
> > +			name = XATTR_NAME_POSIX_ACL_DEFAULT;
> > +		break;
> > +#endif
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	if (xattr_dentry_list(handler, dentry))
> > +		name = xattr_prefix(handler);
> 
> I'm not a huge fan of all this duplicate logic in the file systems
> that is more verbose and a bit confusing.  Until we remove the

Yeah, it hasn't been my favorite part about this either.
But note how the few filesystems that receive that change use the same
logic by indexing an array and retrieving the handler and then clumsily
open-coding the same check that is now moved into xattr_dentry_list().

> xattr handlers entirely, I wonder if we just need to keep a
> special ->list for posix xattrs, just to be able to keep the
> old logic in all these file system.  That is a ->list that
> works for xattr_dentry_list, but never actually lists anything.

If we want the exact same logic to be followed as today then we need to
keep the dummy struct posix_acl_{access,default}_xattr_handler around.
I tried to avoid that for the first version because it felt a bit
disappointing but we can live with this. This way there's zero code changes
required for filesystems that use legacy array-based handler-indexing.

But we should probably still tweak this so that all these filesystems don't
open-code the !h || (h->list && !h->list(dentry) check like they do now. So
something like what I did below at [1]. Thoughts?

[1]:
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a62fb8a3318a..fd83bbc4b98a 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -496,13 +496,9 @@ static int xattr_entrylist(struct xattr_iter *_it,
        unsigned int prefix_len;
        const char *prefix;

-       const struct xattr_handler *h =
-               erofs_xattr_handler(entry->e_name_index);
-
-       if (!h || (h->list && !h->list(it->dentry)))
+       prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
+       if (!prefix)
                return 1;
-
-       prefix = xattr_prefix(h);
        prefix_len = strlen(prefix);

        if (!it->buffer) {
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 0a43c9ee9f8f..a94932c4938c 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -41,7 +41,7 @@ extern const struct xattr_handler erofs_xattr_user_handler;
 extern const struct xattr_handler erofs_xattr_trusted_handler;
 extern const struct xattr_handler erofs_xattr_security_handler;

-static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
+static inline const char *erofs_xattr_prefix(unsigned int idx, struct dentry *dentry)
 {
        static const struct xattr_handler *xattr_handler_map[] = {
                [EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
@@ -57,8 +57,11 @@ static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
 #endif
        };

-       return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
-               xattr_handler_map[idx] : NULL;
+       if (idx && idx < ARRAY_SIZE(xattr_handler_map) &&
+           xattr_dentry_list(xattr_handler_map[idx], dentry))
+               return xattr_prefix(handler);
+
+       return NULL;
 }
