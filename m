Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD77680642
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 07:51:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P4zNl6fvyz3cK6
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 17:51:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN>)
X-Greylist: delayed 456 seconds by postgrey-1.36 at boromir; Mon, 30 Jan 2023 17:51:14 AEDT
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P4zNf5jCLz3bZn
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jan 2023 17:51:14 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC23968BEB; Mon, 30 Jan 2023 07:43:29 +0100 (CET)
Date: Mon, 30 Jan 2023 07:43:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 05/12] erofs: drop posix acl handlers
Message-ID: <20230130064329.GF31145@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-5-6cf155b492b6@kernel.org>
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

This review is not for erofs specifically, but for all file systems using
the same scheme.

> +static const char *erofs_xattr_prefix(int xattr_index, struct dentry *dentry)
> +{
> +	const char *name = NULL;
> +	const struct xattr_handler *handler = NULL;
> +
> +	switch (xattr_index) {
> +	case EROFS_XATTR_INDEX_USER:
> +		handler = &erofs_xattr_user_handler;
> +		break;
> +	case EROFS_XATTR_INDEX_TRUSTED:
> +		handler = &erofs_xattr_trusted_handler;
> +		break;
> +#ifdef CONFIG_EROFS_FS_SECURITY
> +	case EROFS_XATTR_INDEX_SECURITY:
> +		handler = &erofs_xattr_security_handler;
> +		break;
> +#endif
> +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> +	case EROFS_XATTR_INDEX_POSIX_ACL_ACCESS:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_ACCESS;
> +		break;
> +	case EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT:
> +		if (posix_acl_dentry_list(dentry))
> +			name = XATTR_NAME_POSIX_ACL_DEFAULT;
> +		break;
> +#endif
> +	default:
> +		return NULL;
> +	}
> +
> +	if (xattr_dentry_list(handler, dentry))
> +		name = xattr_prefix(handler);

I'm not a huge fan of all this duplicate logic in the file systems
that is more verbose and a bit confusing.  Until we remove the
xattr handlers entirely, I wonder if we just need to keep a
special ->list for posix xattrs, just to be able to keep the
old logic in all these file system.  That is a ->list that
works for xattr_dentry_list, but never actually lists anything.

That would remove all this boiler plate for now without minimal
core additions.  Eventually we can hopefully remove first ->list
and then the xattr handlers entirely, but until then this seems
like a step backwards.
