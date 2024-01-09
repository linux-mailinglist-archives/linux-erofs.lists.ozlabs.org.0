Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0386828188
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 09:33:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hae9Vcp8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8PMZ66ylz3bnc
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 19:33:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hae9Vcp8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8PMW6Fbdz30gn
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Jan 2024 19:33:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B0013CE176E;
	Tue,  9 Jan 2024 08:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359E9C433F1;
	Tue,  9 Jan 2024 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704789185;
	bh=A8Hyrx8gv2NivKMAgmiyJ4RK4toNpxNWKdpezhMjsB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hae9Vcp8/kaaJWKrCD8n2rypMTJgDsf+fIUhRrlgD2zzHG1fE0pMkgVLy2Aay16i1
	 cyOHkhWI6T9AA0gmkJRtZt2jCOTuc/GnE/NFt35tRFGpCvFIalZbChShpHaOxn17RM
	 sI5RHW0Ki3H0e99EmMwZ6tO0SgA6QAqR2LAPQFlkuKHdVPcV2i/aQ865CceI5/rxfK
	 gR0HZ9dSmm6LFVOSKnwJUC2JqLjmUkL+hI52eC592xyJdoFew40D8m5YvlAVdr2EqL
	 CHVYbJeXgyIcRIjxYeABsn7YZUkU56k8rkALLN+maFLPBr7Q+5gP4DXI0YDvuJOFww
	 WRb5Fwe1ZVgUw==
Date: Tue, 9 Jan 2024 08:32:57 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
Message-ID: <20240109083257.GK132648@kernel.org>
References: <20240107160916.GA129355@kernel.org>
 <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-2-dhowells@redhat.com>
 <1544730.1704753090@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544730.1704753090@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Yiqun Leng <yqleng@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 08, 2024 at 10:31:30PM +0000, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > I realise these patches have been accepted, but I have a minor nit:
> > pos is now unsigned, and so cannot be less than zero.
> 
> Good point.  How about the attached patch.  Whilst I would prefer to use
> unsigned long long to avoid the casts, it might 

Hi David,

I would also prefer to avoid casts, but I agree this is a good way forward.
Thanks for the quick fix.

Reviewed-by: Simon Horman <horms@kernel.org>
