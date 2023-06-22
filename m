Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724273961E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 06:01:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lWV53gdP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qmms628R1z2yyT
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 14:01:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lWV53gdP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qmms24YBHz2xgt
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 14:01:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 35D6F616AA;
	Thu, 22 Jun 2023 04:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96CC433C0;
	Thu, 22 Jun 2023 04:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687406499;
	bh=I/DPIBH9Y5es+NWOTv9QziljXOlqUkgepZjrEJoMG/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWV53gdPK3qQT3ZsPuMCXuQQb6X4lk5ia78C9oIbTZXealwnrpixoj3eU3q0zviDi
	 VbbcWJWltWw9Yfo2069YpYrurq/gq3mRINh7NYiZNIY5xUD8Cfm2cXNnGVxWTkB+NB
	 4l+I43NDZxOUUZrxehgj6TCYnMeu/ygIp+zTOJnbrpKfh6E8nmLmee4ANr1JMe9xFB
	 bEX2r1/RGPCMXvNoCLnVOA7zmjRN4VkJGX49TOgOIv+V4hfjHPtHuWzkEK5syOu/7y
	 ngcIGiqNd6K5cZBX7siLzeZbgIE+tHAOp6fbabIT2SA+zMo63iS35vJLHfNMb9snrD
	 1BFzRLMHAhUaQ==
Date: Thu, 22 Jun 2023 12:01:33 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 26/79] erofs: switch to new ctime accessors
Message-ID: <ZJPHnQXvsKhdPb6g@debian>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-25-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-25-jlayton@kernel.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 21, 2023 at 10:45:39AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
