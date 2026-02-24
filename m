Return-Path: <linux-erofs+bounces-2396-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG3+N9rRnWn4SAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2396-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:29:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF21189CE0
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:29:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL3870Z5Tz3cYX;
	Wed, 25 Feb 2026 03:29:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771950551;
	cv=pass; b=HDKcdKztbx/1aOsLv+VW5FF//HTdDd3ZXx8hmCrwUkKyyrWgAn35VX+AXbpYn6v6FnAOFQD0rrCbV1S0qH6ciNrxIfCyMyUCYPUc5VB1MDIo3/m3aiQjPE2XGYA0sE1zPLYFJ0e7KnBgmspqNep5ktuJW78tZ1fL14l0qyaaFuL8IzrKF0EbFEeqLdcNJONlB6aiyqDOggauE8A0jVZ1Gzjg7KF46uTbxNBTwSb4M6LeE4MOsDyERrKlQH0z+A2fi/ohwh6XekBfXI/BVl4wahaM8HL9QBxlNcIG1cKiui2YaoSUdm9Fp8aFfaU0YcrOfY90quTiupMCmzWPMWDPew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771950551; c=relaxed/relaxed;
	bh=GtfVzYq8sfA7g6nq+lCh5G93MoAXi/0tZYLn/0PN2Q0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=g1ffJjHJ9ylctz6M1JjQ8Gw0fnwiomDtJNX1xaOrIWeSOd1PmvwKpVXxAoZz4omPPgIir1JGAQ7TJmnOehgxyrd5o/w0rHrHYfuUv4gGlqgOb7NrnzRRlL84TYvPwfvmlBPNxoUVB2Ow6KOMbtdbI2D8qjBFCBKYIUt1YT5A0z36Wfr64A7j610WI53z0veRPWQNyQEQMdP6uNUMYyhcbHEXw7tInUjsH3jDpKQFW8h/jtRfkDMBQxenKtqziwlV6b/VZQzq3z4prdrdlUc9pPIOMtAL2F7HJ/a1dZh2ZAZm5Ba1sVMQ7Nk+AS6k+qfJQ8pJHOIFhxkUMFG9sUWeJA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=fVPnSDxj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org) smtp.mailfrom=raspberrypi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=fVPnSDxj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raspberrypi.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL3846d11z3cYG
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 03:29:07 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-5069ad750b7so50319321cf.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 08:29:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950544; cv=none;
        d=google.com; s=arc-20240605;
        b=ajizvpHkEvg+m/32UKoD12afWnXkBTBN6nrV1e9aR0F/PiaUwfG48+xsDuEcUWm1EV
         q2cMUPoxmSKNmIhWeCpAkPIyxTIL/JdPmmDt1x3j/dFkTb9qu7nkpfI6lGezkhMOmVG2
         b2VImO4Z4OqZ81cDRKwux8ig3zpFqVz4YyM2ucCZQmXN9nN3tVQvX9W4cR1+zDZBjcfl
         +VfeQupW1WhqEewChpRXXAuTt9FW1n/g6Mg4AO45LUl8DNCj31lMQ9aJ9qivmZataZzb
         YrW0pikMXezJEZrqQmDHD+Smng63LvYncCwSabj/UHtTVbOhITvrmojwaxU7z8k13ws5
         M1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:dkim-signature;
        bh=GtfVzYq8sfA7g6nq+lCh5G93MoAXi/0tZYLn/0PN2Q0=;
        fh=utONbU7d+l7qEhlPylNGoqFbEyvb8LrAzj4wiOPz160=;
        b=FFfiIlTbEgmqptQkMOnBbkpHb95+6DJsUr8hRDnhu7CnIWOOfadr0cXNs7d3NT3bbU
         2XjVodC+ymCuy/7nYP+eLe+W4rMd4FCtfcJte5twImZymFRat9JKZ9B+Vc8jQ41Hci1o
         3l+sJ5hIJaniwH9hE8jw00kY7d2944vVi8UMTYmXHZ0ns93FNyCDUP7bLFGPvMkV7O+0
         y4pQVJWOZxNnytYtXJ0Kp6K+7sxsK25ngTXkFOoorfJGNbUZBHu3HwS7rzB4kCVN/KDV
         JKU7/FblQC3UlLgS5HCeYZcOhnjJ8cdh8jKTZzqkiO87MyZ57PGygQ7RckOhiKyi804k
         HUcQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1771950544; x=1772555344; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtfVzYq8sfA7g6nq+lCh5G93MoAXi/0tZYLn/0PN2Q0=;
        b=fVPnSDxjxwI2H9El19EcpjKFYpdOehlU5rzvCdKAWDw/uBo7TVcvAwq0s4q22W6AGF
         l1+LemXCzqy/OoaIFlHS0aM2AQrHT0GADuLpSCKTmYMU6OCsVIVroMtToqiAS+KgxxgR
         PACrYsNYirUrZ2OnNt4asVtoCzOm/ir/ExOoZo1DeS4Kigv9PgzVroglfpKeBknWJpzz
         POVlbUTTp0zt18Y3gY4Cw6YMQcu+Jp14rIvcUFCi+IQHIKRYqNu/1LXTOHy1eTGsnoYX
         KIzu4R4/C0AAjLtG283evKU2ZdkS3NIiK4/OYOxZJL0LnrnbYq9ZfBgqx1aYNwMoDM8O
         IRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950544; x=1772555344;
        h=to:subject:message-id:date:mime-version:user-agent:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtfVzYq8sfA7g6nq+lCh5G93MoAXi/0tZYLn/0PN2Q0=;
        b=gBbd6qe/ID+bYKtzMW0OyWdQVHp3lnvR2PmL2dM+iWcZ8OvDNmE09cjL9qarQvz+GO
         gO0NXhUwCMqxRL/1NN6SC0gj38ro+RA7mQlF5zSd/JSaO1e8ifSWlbwX8g9IpmFdit/S
         MlJAXoGN5HUp6xI5NLccsVSuQ7PCj4yjyWoZN01KVtq33HVP4JE93PhQKWbbWFtApXy7
         3Ovz/JSTpP+Fkei563u0yOJbMSEvxEHm9MPydRfuz7zsPqceqeO3WyRftKymxTLnlmFC
         FUbQm5RhXMfW/tU8Cu6vLw7RP/Ewma7R76TxDMOA8AFVGwh6grQQ30Zk31nu6muYCLAn
         Df7g==
X-Forwarded-Encrypted: i=1; AJvYcCW7aclvr06PWzvIxx5G8iYeI8kQ8ORhSemxkxVaBuCZ2EENdbP/rXfYZp/Io2V1lieEWD2IEvT9JBVsPQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPQ9KXTtBGwSGkDdgJLlzRFuNk611gQAaBGp3OnqzUpx7rdDiJ
	zczGfQFxeHTSJ7xmhmbqATUtC3sWrcDg7bneE1HdW2wtHUZQC6aDGarUHW5QiMug9FU/cwBUSBS
	EX9OOfrJdNCx8OxnROX00akLe+s+t8AnlqhVpeJQXoQ==
X-Gm-Gg: AZuq6aIS4806SH3FKWiKWShbU2l25SHpnK36oVAqEtqnwXK3OmJy+VIRMGpQivmnnCZ
	r37w61xIhJa1LPHbaoP6etw1H34HADNfl/ePgtmr8rqAaMjXresyJ+zRk7pbGvgONANrx6cBuBn
	4rGfK1VSyYhmMMWY4HPkHyss+WTQsAc5SmQ3B5DMAHGVFOYs4+ONdYyTMcaWadY4lHDuwoQgpEP
	OaDURaYzdwYhdeS9rn7RDbxT2nLk/DwQM4xmAMjAjgQN388CNHcn/pmOaDqBmCxaJ/h9aUEirgC
	KhTIlmMD
X-Received: by 2002:a05:622a:102:b0:502:e1ed:c352 with SMTP id
 d75a77b69052e-5070bc6b51emr167219661cf.45.1771950543838; Tue, 24 Feb 2026
 08:29:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 11:29:03 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 11:29:03 -0500
From: Matthew Lear <matthew.lear@raspberrypi.com>
In-Reply-To: <450ee7cb-8c30-420f-a7f0-c29238e2ae90@linux.alibaba.com>
References: <CAPrOGNDb=Y1yt_m=NgMSj01Np0yCDF2TYTV_dY_nV585=eX6aA@mail.gmail.com>
 <feb908c4-5e9c-4ba8-9818-6b6b66e9b4ff@linux.alibaba.com> <CAPrOGNDnCBYdUjOiXBiVKSmLcPW_jxZbHXLdgMgj-T6LnXo0ig@mail.gmail.com>
 <450ee7cb-8c30-420f-a7f0-c29238e2ae90@linux.alibaba.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
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
Date: Tue, 24 Feb 2026 11:29:03 -0500
X-Gm-Features: AaiRm51KFnujPsoTKhqWDuIYaiGjSEEX0uFxRCSEpEHN5dyHWCxBJr9GPRfz4Ho
Message-ID: <CAPrOGNBnKj37HBav+jGAVGk2xiz2DY5kOPO8usDU2KPEwcJLxw@mail.gmail.com>
Subject: Re: mkfs.erofs: should MAX_BLOCK_SIZE be tied to build host page size?
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2396-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: EBF21189CE0
X-Rspamd-Action: no action

On Wed, Feb 25 2026 at 12:09:07 am +08, Gao Xiang
<hsiangkao@linux.alibaba.com> wrote:
>> With 64K, the memory footprint would be significantly larger.
>> What do you think?
>
> I understand your concern although I think they are just
> for temporary use, and 64k is still not too huge and
> the userspace stack is less worried.
>
> Or how about just use max(PAGE_SIZE, 16k) instead for
> aarch64? then you will get 16k for most of the time
> unless PAGE_SIZE > 16k.

That seems a good solution, and I imagine we'd want to retain the
existing configure switch. I'll work on a patch for submission.
--  Matt

