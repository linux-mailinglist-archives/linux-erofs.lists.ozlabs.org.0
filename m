Return-Path: <linux-erofs+bounces-2303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPa4BjssjWngzgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2303-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 02:26:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93A128F4A
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 02:26:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBHgn3Xjhz2xcB;
	Thu, 12 Feb 2026 12:26:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770859573;
	cv=none; b=WJya9GOlK74hPIJzjAd1ATronky/nO2ailPELkUjS3z4ldJZLAvl7glmnH8Qus4KYiMwNu4rTagDnjX2wx8L1n6B8O7bIbqnujq/uGrNzDNvNWOOPzVu0sHMcNAxCRu6sdhZye3/sLJdE3dbOBmI7iWWdyUaUdd5C+cG9U1AcPRJ7041tumkPbJJ7jqphyk78F2et/Fvm4VFe0e+IF3B/Hk01RM6JsWKvzEdJFRigDEM/Vds0XILQtrnIQFkDZ3giajNF8FuGnGA88EBTdB0XR6kK6fZJhLy9K3kc2FLguEkxJTt8m9O/mxxphRqLu182CYsJzUpOPLJp6c+u4qgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770859573; c=relaxed/relaxed;
	bh=MnWM5vftEoMJ6PFPiSrU/WOcC2XziVVbN1gjO6QwIFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDocy+UFYMWWJhpcK5G0uBdS4Sgn8ASGj08KNfzrrpW4/l7+8wQC1siZrguMCMyYIb1jzF/gWTTJMHoLHHj4mtg14oIvy1nxpHw0RKMgos9TNVAGvrI90evSFpYC36TM3Wm7MY3DFEkdrcYDlak2IFMpOiwAIfbrvx5ananRzr3rU6LTHEQTlJkeZfWoRNK4rQ4U35xw5pwjbIwhRACJvU1I7NsPdn3yOV5T+7lBOmyfkEGoD6AAO+ZGb3KkqejRkNiralebvsJfFYpwAQlcmnwOjUT5tCuCb+0Z49SsAurUZ2I3tzgN4QLA4OLOMwDiA4s8kBfEIwZuNNT+ZTfNuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aYr4dXYD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aYr4dXYD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBHgm5njFz2xHX
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 12:26:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F0F344139;
	Thu, 12 Feb 2026 01:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F2C4CEF7;
	Thu, 12 Feb 2026 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770859569;
	bh=JV/kkfoDHxd2O/A+38UA1r5fnaY74dcBY0T1JAq9RoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYr4dXYDh7ELIhOo/xqjQGQOAd6dYQ368hraGaxQs88KKVSg/DoxBkRcBWBrgSwC2
	 mnjbLNBuqWFJviZNdJeK8e3CoCNByIHrXb3UH97m6w7xstcOpVUZd1wcOstGNq340c
	 GGXIu4Qnss3cTQlghPzZxwluLkQePrU+qulXGFSlqe9JYFTBdJO4CA/RLXJAYoFz4B
	 96vcH2In6tU23frbv/8xOzd7g+HDN0mHLlS1A1qLQ5WrBIrlHKCU3MCurK5ouONAkk
	 IdzO0RprsPZRxOHlGtwE2ouWyYT2201Gq4l/+kWFOaNygTfIfxb/Ei7UB5+fxAHzd2
	 tEgQj0ll4dzNA==
Date: Thu, 12 Feb 2026 09:26:04 +0800
From: Gao Xiang <xiang@kernel.org>
To: Benjamin Drung <bdrung@posteo.de>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: manpage: document missing --quiet option
 for mkfs.erofs
Message-ID: <aY0sLFNqwhGY17av@debian>
Mail-Followup-To: Benjamin Drung <bdrung@posteo.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org
References: <20260210182840.2108213-1-hsiangkao@linux.alibaba.com>
 <2ee1ac1a6072f92c80b817e3413b0610f802bc6d.camel@posteo.de>
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
In-Reply-To: <2ee1ac1a6072f92c80b817e3413b0610f802bc6d.camel@posteo.de>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2303-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bdrung@posteo.de,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: 4D93A128F4A
X-Rspamd-Action: no action

Hi Benjamin,

On Wed, Feb 11, 2026 at 05:48:38PM +0000, Benjamin Drung wrote:
> On Wed, 2026-02-11 at 02:28 +0800, Gao Xiang wrote:
> > Reported-by: Benjamin Drung <bdrung@posteo.de>
> > Closes: https://github.com/erofs/erofs-utils/issues/36
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  man/mkfs.erofs.1 | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> > index cc5a3109ac7f..4316214ff1e2 100644
> > --- a/man/mkfs.erofs.1
> > +++ b/man/mkfs.erofs.1
> > @@ -240,6 +240,9 @@ Use extended inodes instead of compact inodes if the file modification time
> >  would overflow compact inodes. This is the default. Overrides
> >  .BR --ignore-mtime .
> >  .TP
> > +.B "\-\-quiet"
> > +Quiet execution (do not write anything to standard output.)
> > +.TP
> >  .BI "\-\-sort=" MODE
> >  Inode data sorting order for tarballs as input.
> > 
> 
> Does mkfs.erofs also support the short version -q?

Nope.. generally long options are preferred unless the functionalities
are vitally important so that it deserve a short version (I don't want
to have arbitary option list from `a` to `z`, also if some common
alphabet is used for an uncommon usage, it will be hard to remove or
switch to a more useful usage.)

Thanks,
Gao Xiang

> 
> -- 
> Benjamin Drung
> Debian & Ubuntu Developer
> 

