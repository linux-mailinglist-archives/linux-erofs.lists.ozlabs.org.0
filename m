Return-Path: <linux-erofs+bounces-2811-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAaEKBSHuWmTJAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2811-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:53:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E992AE977
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:53:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZyhb1cMvz2yhV;
	Wed, 18 Mar 2026 03:53:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773766415;
	cv=none; b=Upzl6/vPb29z/nZUZ21LI5EQIKY/hgr167vNifl87SlEq+kLXTWZoG2ISZQuYYsaz65/kSnmKmQXNWAL690YT5KuKPqww+ESn52lucXsqPgU0sh7bBLlE3T7WdVN+A7QxfGgQJrypf9vSb9vgFDigK7WG22g+TKQ7oHMDtZydKpsGrn1zE311rOn8PeadIN9b0u6cwZ9itee4kCl9F20wscMeaTSXR2Ocbz1qw4zO+V2ICnKVo2bicN2yVS5Ydf18xUSHIT+Oza96160nkI8J4Ke9cAPW5OUdMuaFED3XbQdwIJr4Ue9L5pFduk+12q5LAwkyypv+EruUeLzCx68/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773766415; c=relaxed/relaxed;
	bh=Y5z+rgLS51frvSLwg0Nkex7AHBR+mY9bMrY/PWmKLMY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeNn3xyq6mv3mc54MIEbzcPf0TkO2w23MbTcWZFBo9HWlB5aM6L5MIJ/I5/8KSZq9pvd5aP0Xf4Gp+8R7z2OfNStQAFICQ/oJdLpndPbA4R1YGYMXD2IC1tGVpokbyQTJZln23VWulKkNbd5mksP59qBr5ilXjsMuMwXZ+C6FaDm9tuaOvQcqT+6UkVJD+xRk76fQUQHTzgavU6REiOT4G8a6Oy0EleaCuu/R84mAhpy59Tw3JmHAOD/hceyxMcGVpf9aWeQ3Oc5zIyB1NPWL0n4nu+uyBmRFxLlmoAeumaBETrBRKaaH+kOecqfCzWX2o9Fey8zkRuqQD64hykXpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bf3Kb1F4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Bf3Kb1F4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZyhZ3Ts4z2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 03:53:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C2FE60127;
	Tue, 17 Mar 2026 16:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B298FC4CEF7;
	Tue, 17 Mar 2026 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766411;
	bh=Tcz0AvYDRdBlJGZ9MVIUdG0twLRlMG4315EGYr87UrM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Bf3Kb1F4jEnViJwaDlA2DdJk2ejqyww+PgnWq4jXe7P25IfBTu0XdzhJKhXELuWEu
	 9PSkmCQ94gG5hebqWCbXurigNadiooqDs36nD/j2zwaykNV77iaNmisuoiC93qZt/D
	 Tm0tVTbGNu7f3hfrj8L5IWaqX1sIQ7nghJFgRIQF3iiEJGhrBHyWhFS8QPmQmbq0Uz
	 eZWAgkx6+r/d7tSqQ/iMYYtcpR6RE7K6OQ9ClIlfM+Aq2EwZA2NCqZ8dG4ecvwkpD7
	 wsdYKdGKdnOopht5m1NiBGPpeAY7VSHejLZWJlN99g7UF7wvTk3X03S9Yy3zXl3FV3
	 9FOvf6ArHrm+Q==
Date: Wed, 18 Mar 2026 00:53:26 +0800
From: Gao Xiang <xiang@kernel.org>
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org,
	xiang@kernel.org, yifan.yfzhao@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: validate h_shared_count in
 erofs_init_inode_xattrs()
Message-ID: <abmHBmJ1SjhHTuOp@debian>
Mail-Followup-To: Utkal Singh <singhutkal015@gmail.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	yifan.yfzhao@linux.dev, linux-kernel@vger.kernel.org
References: <20260317152439.5738-1-singhutkal015@gmail.com>
 <20260317164135.24892-1-singhutkal015@gmail.com>
 <abmF9Nn85cz35C1k@debian>
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
In-Reply-To: <abmF9Nn85cz35C1k@debian>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org,kernel.org,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2811-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A3E992AE977
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:48:52AM +0800, Gao Xiang wrote:
> On Tue, Mar 17, 2026 at 04:41:35PM +0000, Utkal Singh wrote:
> > A crafted image can set h_shared_count to a value much larger than
> > what xattr_isize allows. The loop in erofs_init_inode_xattrs() then
> > reads shared xattr IDs far beyond the inode's xattr region, causing
> > an out-of-bounds metadata read.
> > 
> > Add a sanity check ensuring:
> > 
> >   h_shared_count <= (xattr_isize - sizeof(erofs_xattr_ibody_header)) / 4
> > 
> > Return -EFSCORRUPTED when the check fails.
> > 
> > Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> 
> What happens with your v3?
> 
> What happens with the commit message and the division?
> 
> Could you explain what happened?

BTW, if you insist on this (I don't know if you're just an AI),
I will never accept patching made just from AI bots and keep
failing all the time.

Thanks,
Gao Xiang

