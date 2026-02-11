Return-Path: <linux-erofs+bounces-2301-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGb2IMvCjGkmswAAu9opvQ
	(envelope-from <linux-erofs+bounces-2301-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Feb 2026 18:56:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66963126BDA
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Feb 2026 18:56:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fB5hk162gz2xlk;
	Thu, 12 Feb 2026 04:56:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770832582;
	cv=none; b=kf6mtXuJvmPPSkbUk8oeLb0OqGyiaBSLJxU1jvpBvoOio3H3XO7dzTjIyy6k9Z5CliT4qS5sPvefgoH7PiVABkeEgFgk/BMOm8JCVnWlYq3WQEqYOPMWhXw3NKb+pfJKfRS+7dcLYbCK8SQ7bv1o0f9Kbu3GEPYwPpiCXH9SYmox6RSR/EqKcewl+jb+3xfphkuLjuLvQ5jnLnWCj1CDlJzSYHB95oAcmoysgE04ogYbLz7JBEQqeMStdQD4KGJtj9N00RwIso3qJG0GegsOIjv9l7a7TOTrQn2LVmfMRFMTX+JFqgKa+98CwHb7Mwlbt+P8KT6jaltzR7nDfzJucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770832582; c=relaxed/relaxed;
	bh=abuKaJ7uLEM2efy56FqFpoLN+SyQoddsXrFZ9JQJcOo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElZNNXh6Xwm3riRFr+G4FO9RGhH1uvHkNAuU7Xx7JTXP4tUWMOp1sclgRn1GVsbLePL6/2aYIfIBGCagDAteM9cjv/nMRbwK8X80yC/PccdU4L6RYcmPL0egOu5l1iUbN4+EHz0bedRiuKmiJiNBKn3cI6uRSuNbqJbO44NbEydO1OtilZUakunMC+mwiN5/uPHHaP+93JD7lfrlgTETa4MkmcrqAy0CjAyElOwMb2OEqhEUODSSzGr4rS18fPiQWkKLKGr4/MkhtuB1bPmcV/TRODfBdZ5F2awRKl1nNF6CN99QPoLLalBiWYuZz6T4sOfwZHFbNOb6VBNnwxvbWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.de; dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=2017 header.b=MWQCUwzB; dkim-atps=neutral; spf=pass (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=bdrung@posteo.de; receiver=lists.ozlabs.org) smtp.mailfrom=posteo.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=2017 header.b=MWQCUwzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=posteo.de (client-ip=185.67.36.66; helo=mout02.posteo.de; envelope-from=bdrung@posteo.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 453 seconds by postgrey-1.37 at boromir; Thu, 12 Feb 2026 04:56:19 AEDT
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fB5hg4S94z2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 04:56:17 +1100 (AEDT)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 89CDC240103
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Feb 2026 18:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1770832119; bh=abuKaJ7uLEM2efy56FqFpoLN+SyQoddsXrFZ9JQJcOo=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=MWQCUwzBU2K6EP8uFn0wknPiucgHPgIae+IQKevu8OclTZL9YoU/DO0eQ0zYpsf02
	 9BkaUDSfweR/aIMv2n2S8Dky9uZuKuu7CSncW+EhyRUM7Nvt9tVW/BJ+6DO0Scb8kp
	 7WCyohb8+TTh3WY+2Cw2Se+rsN0AD+uYIICq8XTKTta2T8navm8tNfdRqnKAnrawQe
	 x7qxT06DZeUj2BeT9A8G6oPsBykIjH+37CakJFrhcyJvOI65nntV1wwcSECCS41SCN
	 64CuhCe4aFteUE986tbYIgPEx+lXho2xU5p3iJLqyQgvHiGmvE034vzhtUUbKXymcA
	 Kz9uN2sbJOE/g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fB5Wp1Wfwz6txj;
	Wed, 11 Feb 2026 18:48:37 +0100 (CET)
Message-ID: <2ee1ac1a6072f92c80b817e3413b0610f802bc6d.camel@posteo.de>
Subject: Re: [PATCH] erofs-utils: manpage: document missing --quiet option
 for mkfs.erofs
From: Benjamin Drung <bdrung@posteo.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Date: Wed, 11 Feb 2026 17:48:38 +0000
In-Reply-To: <20260210182840.2108213-1-hsiangkao@linux.alibaba.com>
References: <20260210182840.2108213-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.de,none];
	R_DKIM_ALLOW(-0.20)[posteo.de:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[bdrung@posteo.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2301-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bdrung@posteo.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[posteo.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.de:mid,posteo.de:dkim,posteo.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 66963126BDA
X-Rspamd-Action: no action

On Wed, 2026-02-11 at 02:28 +0800, Gao Xiang wrote:
> Reported-by: Benjamin Drung <bdrung@posteo.de>
> Closes: https://github.com/erofs/erofs-utils/issues/36
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  man/mkfs.erofs.1 | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index cc5a3109ac7f..4316214ff1e2 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -240,6 +240,9 @@ Use extended inodes instead of compact inodes if the =
file modification time
>  would overflow compact inodes. This is the default. Overrides
>  .BR --ignore-mtime .
>  .TP
> +.B "\-\-quiet"
> +Quiet execution (do not write anything to standard output.)
> +.TP
>  .BI "\-\-sort=3D" MODE
>  Inode data sorting order for tarballs as input.
>=20

Does mkfs.erofs also support the short version -q?

--=20
Benjamin Drung
Debian & Ubuntu Developer

