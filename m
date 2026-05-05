Return-Path: <linux-erofs+bounces-3379-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHuOCxFQ+mm8MQMAu9opvQ
	(envelope-from <linux-erofs+bounces-3379-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 22:16:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588614D38D7
	for <lists+linux-erofs@lfdr.de>; Tue, 05 May 2026 22:16:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g98sd44yFz2xlt;
	Wed, 06 May 2026 06:16:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778012165;
	cv=none; b=LVUFsAXnSmlSXyItU47QwzGvWc9lV2aulnGbQJe1MJdj5JJGN8PlL8kldV9bxv8guHvjpBPoqsZ0zXLRYjVmp/MEaV2Y8eYt7k184yAeWezm4I78MWEGAv1WiNxEt0IcEQoT0rr1UlRND/LPJGQUu2Bjx3CgFZgNgAPI5iiUKb1M7YT9U3Rjb7gj1N04mu2U8czuX+KW8ePPMcgxh7Q3debbSCPGCFRXDjAoZ30fQcBIIv+zjONsTNO6o6DS+tRRBWE06vOmOfHOqPCdS6GjgoEBzYEYUHJdKYUyns87mAtZDNylRsjVTg8qrO5dV5G7FxV1OP2BtXTPG9MIOfZtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778012165; c=relaxed/relaxed;
	bh=ldwTHAfh0gpdQ0E2+9eeUK8kcdVFjR2c+5XrJHhKjzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOf6pX1me0PDPZcFcAm68rGNu4fgj4HnWfwuULx1WXyyEHm/GyGSGuU3vRa/f27q7gGRdRrh1pA98dujArf1FEO45fLtjfwoBoeyDeqjFp/fLf6tHRl4nehV7LOiM5Kd4gtxzQtWAFBSgQogzkfN7KBIk28l0GPOqxm4v5R6S6RfWkpcRNKQw/TlwGUDkELFjVHGqEztKcpq1cwH/981Sy6CPl4lVewLB4/qceR2TVfVoMLeDqX7EAJAZwB3g7zVbA7gf6PNuigrhUVypgJTj7B+EFacRjFlCfembw/yPr+UuuC857wqS/UTLDXXOXyDlPqxrab3MwYWQQabQTPLiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EbOe0Egx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=cmllamas@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EbOe0Egx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=cmllamas@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g98sb715Sz2xfB
	for <linux-erofs@lists.ozlabs.org>; Wed, 06 May 2026 06:16:03 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso8585ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 05 May 2026 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778012161; x=1778616961; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldwTHAfh0gpdQ0E2+9eeUK8kcdVFjR2c+5XrJHhKjzA=;
        b=EbOe0Egxsyjf+PPpCmP3o4yBptLCGwQ5Mvpxxsv+jwqsaNCjbMqMEbhirC+9JqHbqr
         cmak13bv4AuasG+r/p2iZGAfBZ1TniuB2gkGtsT6ApUmls0s6DcvCjbNNUeBbiIGoSKF
         NgKgk1+zyymOU5swcUY7ocQPSR41gNtXjbUImEUaOwFmHRNi01ZX45R3Vpw3vowzqgdY
         5sLpCns9teI5VbkavPFw4o5JsefsrBoXl3Q/PrLgDafvWUvDsInoJTKfaTTdU1kheFu1
         uJXZpOZ3bqh9sFeA//0VPQUoSEPLT8VN7D0h+rJdnmODhZsW9QN7NErzuldaUcBw+w2g
         7MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778012161; x=1778616961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldwTHAfh0gpdQ0E2+9eeUK8kcdVFjR2c+5XrJHhKjzA=;
        b=UIygb5jd/p8lh42gHfzH7KEWmWF6JtssZsIm6/++ZCDHWkopE8zxhIJrRPEECl1BzC
         Oo7uVZbB15UY/vEzMKCwi0omI2HRc4xbGG0+Efoq2RoJnuB4MkozK9bc7IKB2u2NGRIO
         A5NZPXq0yM1rRmLffWe2yxBRaicr41+OyopvbdsfudQF3wnWCsTcWNcFhYHnIiavmbmK
         39N3vfIWVHj49puCJ35dNtNMhRG1y96bs6c7rDvBfE8JHN8rh5NQlWBntfpvqkfpWP/I
         M26AKdIBQl7fT88xw7L4vUIc4h07HQYDc0GJM8c7Z0IS8ZsfRddoQAOUWGiJXu/+4a/u
         HZrw==
X-Gm-Message-State: AOJu0YxJVVWzW+27LEQPcCbjbotPGv/4k5ZjKwCjEA5VTmHYjep1YeGL
	ATC5utnrVFqsLTI2NYjKZFlaiRliN1iWMhZ5myC6omUeFlWdBOI1SXExxMYHhsD3tQhxy6/1B1r
	iXNA/HQ==
X-Gm-Gg: AeBDieuWN8r1as85DyXNtPRpUolaeDdcxBepZpVSJAH109C2x4/cnnlahda6o+9ar+q
	MuMLV68CZMhe5ELzo6gHyCaByfzcUy6mWCgjbomFwXAIIIZs9SNhgpZwPYjW8Of7TTMe3P4y+L4
	rO36JS/hUSw+jKz2uQj0gqqbwIJ8dqt4N3RD6dGWnx7lDcsr7B7ZqWJk6/tprBiok6U0PcqVplR
	gm/dosLKEEftzboqur13yep35k45Qz7m4vfMaHa6/hSa41aGyiPqnvGGc5PAfrF8t1GgUHsBMxc
	7Agre0grKmH85sxgTFduEeuUvo0uXaiActbKPvJNJsIGc86TTnlsuWCHrqByl4V+xlnD6ydFNcE
	mhZk1BafHeNWSOZYiXmGTRxFz1CHcf3IUBdOGvpkN0JyNJr8pHD1jlBmzD/vZTb53VcoEM4EDLu
	CDTi3ikVYlCpsr0gWsgermyaxzSs1M/mxi/MtqFEbFaBNNFHOoNHvJGYy1ORcvGBFZA7z7jioml
	H2l2+9CssybVx0UjGwfTVubmFiNlSJvEHJFHHL00kiw72r+AajkCghw2v0l8b/R6z0=
X-Received: by 2002:a17:902:ebd1:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2ba779ddcc9mr1117415ad.8.1778012160513;
        Tue, 05 May 2026 13:16:00 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396594645csm3324667b3a.14.2026.05.05.13.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:15:59 -0700 (PDT)
Date: Tue, 5 May 2026 20:15:55 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
	Sandeep Dhavale <dhavale@google.com>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <afpP-3vSAOEc9cpq@google.com>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 588614D38D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3379-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:dhavale@google.com,m:ishitatsuyuki@google.com,s:lists@lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[34.16.174.112:server fail,2404:9400:21b9:f100::1:server fail,2607:f8b0:4864:20::62e:server fail];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]

On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
> credentials when accessing backing file"), rw_verify_area() needs
> the same too.
> 
> Fixes: 307210c262a2 ("erofs: verify metadata accesses for file-backed mounts")
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Tatsuyuki Ishi <ishitatsuyuki@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Can we verify this patch resolve the android-mainline issue?

Yes, it does. Thanks!

Tested-by: Carlos Llamas <cmllamas@google.com>

