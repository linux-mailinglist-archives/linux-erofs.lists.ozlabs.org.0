Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2515C91AAFA
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 17:18:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3o0wOh+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W92K73yBTz3cXH
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 01:18:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3o0wOh+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W92K26fyMz30fM
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 01:18:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3F4E061EBE;
	Thu, 27 Jun 2024 15:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9345DC2BBFC;
	Thu, 27 Jun 2024 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719501525;
	bh=hNlvklwWESHsTITC4Xz4ZjyNEZ0W6rbDTEZviL0qPkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3o0wOh+uQMCynJkUwYUjA0WFoGgFGgC09ncK9B7PkfvnNhVCTEt4vJuM4EEEIKvI
	 PneAPhbCHWqZNgqv3+ImOrtB6B/IuSBt4/r8Zn0NIFc2qoam8ZdcYzq09eWCTftYqo
	 4OwiOGvsGy17z9Y+YjYFsi9HSl2bziEp07rbb75DU5ali6lj8HQ6kUMoAYx4RGFOmM
	 gFR1tNo7vh+8190GYToMAmNAEXr7BoOk9+eNXlIIjE33JGpLFOZgN+/p05Anxygn+g
	 woks7DoYhoAnQXV03dHCVewsMNdrsB193kvvP8dpx+oryMSwuD0lrAzeX/kc+M/a6P
	 lVZ24ywVVjSUw==
Date: Thu, 27 Jun 2024 17:18:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH v2 2/5] cachefiles: flush all requests for the object
 that is being dropped
Message-ID: <20240627-beizeiten-hecht-0efad69e0e38@brauner>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <20240515125136.3714580-3-libaokun@huaweicloud.com>
 <5bb711c4bbc59ea9fff486a86acce13880823e7b.camel@kernel.org>
 <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e40b80fc-52b8-4f89-800a-3ffa0034a072@huaweicloud.com>
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
Cc: yangerkun@huawei.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 27, 2024 at 07:20:16PM GMT, Baokun Li wrote:
> On 2024/6/27 19:01, Jeff Layton wrote:
> > On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > Because after an object is dropped, requests for that object are
> > > useless,
> > > flush them to avoid causing other problems.
> > > 
> > > This prepares for the later addition of cancel_work_sync(). After the
> > > reopen requests is generated, flush it to avoid cancel_work_sync()
> > > blocking by waiting for daemon to complete the reopen requests.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> > > index 73da4d4eaa9b..d24bff43499b 100644
> > > --- a/fs/cachefiles/ondemand.c
> > > +++ b/fs/cachefiles/ondemand.c
> > > @@ -564,12 +564,31 @@ int cachefiles_ondemand_init_object(struct
> > > cachefiles_object *object)
> > >   void cachefiles_ondemand_clean_object(struct cachefiles_object
> > > *object)
> > >   {
> > > +	unsigned long index;
> > > +	struct cachefiles_req *req;
> > > +	struct cachefiles_cache *cache;
> > > +
> > >   	if (!object->ondemand)
> > >   		return;
> > >   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
> > >   			cachefiles_ondemand_init_close_req, NULL);
> > > +
> > > +	if (!object->ondemand->ondemand_id)
> > > +		return;
> > > +
> > > +	/* Flush all requests for the object that is being dropped.
> > > */
> > I wouldn't call this a "Flush". In the context of writeback, that
> > usually means that we're writing out pages now in order to do something
> > else. In this case, it looks like you're more canceling these requests
> > since you're marking them with an error and declaring them complete.
> Makes sense, I'll update 'flush' to 'cancel' in the comment and subject.
> 
> I am not a native speaker of English, so some of the expressions may
> not be accurate, thank you for correcting me.

Can you please resend all patch series that we're supposed to take for
this cycle, please?
