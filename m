Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0C76A9DD
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 09:19:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5orV3In;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFRLd1YDjz2ytc
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Aug 2023 17:19:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5orV3In;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFRLW49kmz2yDL
	for <linux-erofs@lists.ozlabs.org>; Tue,  1 Aug 2023 17:19:15 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA56614A3;
	Tue,  1 Aug 2023 07:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C9C433C7;
	Tue,  1 Aug 2023 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690874348;
	bh=jnyy5lbqh8mKeSlCJwRDU0YAxsEpR+81SdigSgifSek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5orV3In/o/+my1+x2Cl/d7BP+kFQ6XA9J9sj8S/DFdXrRcfYpvKbwXyp8i1vU59h
	 VC5nODiveAkHwtveFBxKHjWTOBy/g7o74VbVJo0ZhLR979cpgmdAsSSDYc8098H6CQ
	 yIUGGKbD8uNNwUHjVlEkhyLIdi9jMWtSJAjNdP9se0sLZ89Q4ZO20CkVRdtviyYdL9
	 r0HjGEgwwUinapusUiDfhJMOqzec+Zx9je6YYlZewQhVy6wpu5DaH76yMI+91xW3E0
	 dn7dErk4xOEai9r2u5JiNvv+/IiqP9FSXdiuiXLID90dYJCQ/kOvNdkEG39KIqLSoI
	 vTueQME4V9HEA==
Date: Tue, 1 Aug 2023 09:19:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: drop unnecessary WARN_ON() in erofs_kill_sb()
Message-ID: <20230801-halbe-bankgeheimnis-792a18bdc440@brauner>
References: <20230731-flugbereit-wohnlage-78acdf95ab7e@brauner>
 <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801014737.28614-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 01, 2023 at 09:47:37AM +0800, Gao Xiang wrote:
> Previously, .kill_sb() will be called only after fill_super fails.
> It will be changed [1].
> 
> Besides, checking for s_magic in erofs_kill_sb() is unnecessary from
> any point of view.  Let's get rid of it now.
> 
> [1] https://lore.kernel.org/r/20230731-flugbereit-wohnlage-78acdf95ab7e@brauner
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> will upstream this commit later this week after it lands -next.

Thanks,
Acked-by: Christian Brauner <brauner@kernel.org>
