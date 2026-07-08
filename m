Return-Path: <linux-erofs+bounces-3863-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z9QyGulHTmpgKAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3863-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 14:51:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCD72675F
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 14:51:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QhaiwETO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3863-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3863-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwHzT6RM1z2xll;
	Wed, 08 Jul 2026 22:51:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783515109;
	cv=none; b=lePOZxukyT6iUKOrKh9IDney5Xjg+5RoPP7LOhHfVeYU8XkgIWFobSWe58tCtG3oPNYm+mf1rv9XFMd2+lRvpCtPzykT8gZhOpv6O/RO5qtseneikC+DkVvFymKcHV/z74BhhFYJ22GpU+iroOvTdfCEh85Bug0NHHEUvMbl3xmEpVQFIfNtMOyMwEn1fbOO0PXcq5HRrFMcuqT6Akpwoo/TQ0Hn281d0qXbeYxgDnjAJH8dzbVTSDQdZdWj5c7eLQkCy7EvBro5iUedcpb9I5HUvSm8lDiUjmrInVlycf8NOJZ6igC5r37D+eLC/Vjp1lb1vUU4xyTi0pkg6P/n+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783515109; c=relaxed/relaxed;
	bh=QRPUyGPfTdccGwt58sEKWl+IWzR/UejjR9lig5WYGKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx34fvXit6F71rboOfTSPHGzCg4u4Q0XJIIXquIlX/fM0V7yZ+g7BEk9u/Uj7ANsNbcjUQiOy5GUE51syUGQtHVcKSQSUxd1OQq5q3H+rG2eaGvKqoQa83u6BlurlNWdFnarN8Cvvgv9b9nSIZs/ErPnhsh9AiaOlo7JhR2VKGbWobD9Qpzkl4VZ7m9QcGAxAJEiPMcDcHNfJixKFEShbwOp7vOFKXo/JE1iU/3iWNBo/PHwx4JwM0KYuQRXa3eVAC78FZXmPr7e46YVrlzRzRWyR2lUrTLFUo6nXFBMTfpNx1qHr6v7b2oS9idtgf5E5NKUu0wNzZOlxwQ4VZHpKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhaiwETO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwHzT1dY4z2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 22:51:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C391C60008;
	Wed,  8 Jul 2026 12:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7C1F000E9;
	Wed,  8 Jul 2026 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515106;
	bh=QRPUyGPfTdccGwt58sEKWl+IWzR/UejjR9lig5WYGKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QhaiwETOGKXor5vMCHcRg2PzUbS8ZpsAphiuOu4hDThdjT4fkYeCvlap8//EIgiVH
	 JanpHZsLmY2raWY5Nng8QZbIDeFlHvgO2WySttV0Z1DJ8EScCuJdo423CUoVL1a2hA
	 fxio8IRXF24rCoVDe75y1CxkNdQnhbeLG/EG3vjwcXJt/7lAwOqA1Y4p7W6mbXWcKw
	 6eAxHFaynZd+dYfCtLkW8eHhzZg7cTdJ7bCnCFKW1pa3gIELxrLxt1HMgSo+dfgC1N
	 aNgKTnKqKR7mumD4Mnu0qh6/RXcFBy9ikq1wFu64TzzfO3MhGdwgT6sReiz30pSBI7
	 GQqm6ZmV41XBA==
Date: Wed, 8 Jul 2026 20:51:40 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file
 descriptor
Message-ID: <ak5H3N5c0ccCwv6i@debian>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20260708093446.3370200-1-gscrivan@redhat.com>
 <20260708093446.3370200-3-gscrivan@redhat.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708093446.3370200-3-gscrivan@redhat.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3863-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71BCD72675F

Hi Giuseppe,

On Wed, Jul 08, 2026 at 11:34:27AM +0200, Giuseppe Scrivano wrote:
> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
> backing image file for file-backed erofs mounts.
> 
> Returns -ENOENT for block-device-backed erofs mounts where there is no
> backing file.
> 
> The UAPI constant is defined in include/uapi/linux/erofs.h.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Thanks for the patch!

The functionality is indeed useful to users, but similar to overlayfs
one, I'm not sure if the interface is the best way. Since after we add
this to EROFS, we will support this way forever.

I wonder if there could be a way as a common vfs uapi to get source
fds, but I don't have better ideas for now... (that is why I suggested
to Cc linux-api too..)

Thanks,
Gao Xiang

