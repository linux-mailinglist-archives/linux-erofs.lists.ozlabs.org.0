Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A5638AC5
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Nov 2022 14:01:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJZkW4kbpz3dvc
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 00:01:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rN3HdXqT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rN3HdXqT;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJZkM6jLYz3cFn
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Nov 2022 00:01:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D7B01623D2;
	Fri, 25 Nov 2022 13:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E731EC433C1;
	Fri, 25 Nov 2022 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669381287;
	bh=Bd6+TW+SUllGke4xXPsi3E6NWwGNc4MDvTSGFvrCkNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rN3HdXqTCE4bVjC5CMTwEYV/a3IqLkxDV8dp6hFvDxLFX7AnpNe8ReTonzysdsYOH
	 Z8uxb6ZC+Pzpf/C76pu/5Sv0zibmR6Hu1RB9G0Og5MecEpDXIBvcTp8wXTQLuPA0H2
	 irjJcfK9oQK/83jsOKllASa9HpcPSDP460eKPrJoenS1Uy3yGBNvfMWjnfcj9Ny2hA
	 V7c+OOkTU1rj36gqP+plmOFMGnYcfXVgyIQiyCCIVua2ZkyDO5vLRb1DsXxff+Jt3u
	 JCb0In9/OEMc6LiCC6iQDPCFRsWf3y3xE5h2OmSigcgPq+yrmVX0j6mHIhMkBGGY2R
	 ht3jRsPiafuTg==
Date: Fri, 25 Nov 2022 21:01:21 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v5 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
Message-ID: <Y4C8ocemviAGpxRC@debian>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, jlayton@kernel.org,
	xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20221124034212.81892-2-jefflexu@linux.alibaba.com>
 <20221124034212.81892-1-jefflexu@linux.alibaba.com>
 <2386961.1669377478@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2386961.1669377478@warthog.procyon.org.uk>
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
Cc: jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Fri, Nov 25, 2022 at 11:57:58AM +0000, David Howells wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
> > Add prepare_ondemand_read() callback dedicated for the on-demand read
> > scenario, so that callers from this scenario can be decoupled from
> > netfs_io_subrequest.
> > 
> > The original cachefiles_prepare_read() is now refactored to a generic
> > routine accepting a parameter list instead of netfs_io_subrequest.
> > There's no logic change, except that the debug id of subrequest and
> > request is removed from trace_cachefiles_prep_read().
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Thanks!  I will apply them for -next, and soon Jingbo will
submit large folios support for erofs iomap/fscache modes.

Thank all again,
Gao Xiang

