Return-Path: <linux-erofs+bounces-3384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BgwEhye/WmwgQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:26:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C54F3B05
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:26:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBhyx1Kkhz2xdb;
	Fri, 08 May 2026 18:26:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778228761;
	cv=pass; b=LHgoGnmpW38ZEeuZuR398bMUBdc8tLu/licdm/rYzMtmI3ugZ2QAaubkIGCIQqkfla+OxeSx+puZwbIsvF0lgRtOTLPF0ZTguvjhvoGe4RXUYoN5VOzRo+fnhQDsl+vruDYH8MQ1r9hExR9LV24oGthrkcbxLzYjBTu63Tfdk//ohkQA+qPwhe4TjkCQNz43w2wPFg1UCjMrdYjd1jarxzNmH+Y81GvrmHsfRnita9/i3N1Ti9b6oH1A8a6GLOrixX5SBTnGGsVkQcBsZkerklayoXtVs9ZFhRJmKDcnFdtRkYjakVPjn19jMp0+y2s6ZNZ6P+C+QVEosvd5j7DY1w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778228761; c=relaxed/relaxed;
	bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwuZHIWTKVRtz/b9hM98wHwkqWbc0g8VT+FWwXu8aItigOUh2OQIXCleijkRD8baaWQwv75x1ErLbqiMv6KJhXZf0duseNu/19XUyxQllAE8Xirsg6cSg/7Fy4EBBWi+wmvGR8wjt2yiaheEaurW6AJiNUQaGEihWsUfRXOwYbAW4L2WSfo12bDWc4Gtq6hmuSG1IjmymNLq7F+mzsIzJTX0JhkkijR2HUOx4+Q1R/TvMR/NY8zfHaXAELLynx/LvaqgpmFobInu5m/xM5iH2pn65KNKwlrbuMht3poY0rf5xCvTrWizCZFVl1ph76cnMkeR1TYA9Eh3jjSUfb4vtA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qnj7lrQ3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com; envelope-from=ishitatsuyuki@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qnj7lrQ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com; envelope-from=ishitatsuyuki@google.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBhyw2kWJz2x9N
	for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 18:26:00 +1000 (AEST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-573a81abef0so1135925e0c.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 01:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778228758; cv=none;
        d=google.com; s=arc-20240605;
        b=RpYVbKBJG/CAps/PxmF4X60YGKz6r6vp3KhTAQRDSoOSEi7J+X+N1vxGIc0bpDZTW3
         uvSn/fxgHg2gOusAg1Afh7L4c1ehku0ka/v7CVLfS8ssw2ulO6GBXdla9Rlwx8aHXke1
         FRoqyCycnRV1oOnblG2S7UKekUiLqmpqTHO8qNIPwMn+xjm639LyJHbGKMDV1ZuKpCYT
         aFNzHeuB+DqcvNuAu9sHIcrty5hDyYBUiT8i0WqQbTe+rPlqT3ghgw+0DUk/5PpQquw2
         AEBrmGyJF5cYcTu3y7nimDcZ80U6TC3jAkoO3NsccCC7Za1Nxcbh73NZi4vRNUKZkJf6
         MQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        fh=Qqdw7SCRnOVFVFnaptLc4UgzkFIuMSvWUqXsGleJJZo=;
        b=Dx8Ko04o0SnxSvOx8kUuQd9Np2JSlBwUy8nfCf7vv6zzTRyoFO9ZcqmDhZYLhcKTER
         d18mC1BkkxZe6NDVdHtiTOG7e7heFgAQ13/CQn9dU1eBPV0CqfFbkgU9d0o8nr+Y3FbC
         a7Ydf5CLtxgdMAPUtcy3EA4pEz1enNvNAoQYc9ehFjwtm9XbkJsIW4Jk4QRiW1tZGujs
         Dr70HV+KWXSIEcFA6oqmRQpDYUD1iI5WxUBYeNY9vt1MiO4gUZ47RDLeJ/Y2FPLDP7gH
         VFlejEKApW1j5B6w9qkIbZJIyPF8z1RU2A5DqASSqeBKikL8jQKvmUvx9EjZ1uUbcgix
         c61Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228758; x=1778833558; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        b=Qnj7lrQ3cBmu8LCi9lC83X4CL3CQupHaqSKLZflmFyIl/pYS0rQ+QQhvMVFB6Az98u
         clckH+nKO7lJi3m334dPPV8+vmjwVDBXbpQwMK8WOEAejEQTJznK7D56qv44CcfiLA5P
         v6dSh4vrWoVY66pOPnFx1Qm9DUTcrbxB0SVhpnlRFi/AVnMv6yhTaHHZb4/TaXbGR2Wy
         5YwszhUpHcRlg4z3fk3J88uD+uRTnyJCsUhzlcLIP41sHoM4WauXv5nMy/MizmunVqM5
         UUGnugm62n6ckHlxtkthcfr+V8XUizhHq6k9aSZdLG7n0rTcmCMbOqIdw5ryQ9Wpa9e8
         /vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228758; x=1778833558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        b=dbBy43UPZt+Qgn/3xrzGun1L5NMWGkAfmvzpvkO58HdRmdLkRtQEzIReiSm9jMTnWF
         CFBJajjenGnVJfCnOHl2KeurgCVc4P7+ayHYOITdPiR0iq6m8GjVIIz50eGnJzAafaQl
         FZ+SRu4X/q7WLmeXG1zyAd5jZge1MgcraidT0o3jaajwZT8VShWQUaELQlFx6Md/rfp5
         lxXGHgpJJolrdCE2cxq0AT599ysHmFsdGL5WtfISleuCfAalLxeRoJeEquARo4jObl1b
         1owceuLPtCp6/rymsYYbUpZA9zZm7u0t2ljlRKo/y56cvyanQ6ss4NCddVRtD43FxGcK
         Drrw==
X-Forwarded-Encrypted: i=1; AFNElJ9ReouTVtnIvV/eSmJi30KpXgKeT65Ya2rzFUoKyJoRj8gxR9c/sOgD0rFTxQa4Pg4ahkByUBHrssGjtA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZiL+2B2ho/dlW7cKhSl/6xs1KtbBhG//XCI60nnoj76Tgg2sj
	pCpgyh6Sb25DKca68nnurgfsEwjJn4b4XRybFbPA3ZmakgCjRyhUIY6XH4Pg7pzPRQBnwVGK2j6
	8pqpurDJpTfJyupPFWiy5NvP3qlXyz7ZTQHk2B3pv
X-Gm-Gg: Acq92OGbpZuVjbfYj9G5j9OAzx5TAI7WPX3ts6KmpJz8UJxMI4H0Q2Y5yXu2WDUGtK8
	g0en7VcWWSrBFdgB6MdMi3zUVRLT4FZAO1oaponqqJhLXsO1zxIbSrptxcys5C2XuzAAh49BTcZ
	rCSXIhG2BeqXARcb3xMQY5Y6Kr+/AM+DBofU8YmcI6H4nTzh6kETvT54LAKWAyrznmOOk+BJq/C
	OrY0EzGjxdcj9gSFd1lfZZsTjRYd07rOb2lPDBfX9mYn5N5Al4xGsb+o3Z5oW2t1lmtq0s0vEWq
	rxneFiOQGSrPl3Lu5G6D/YpUOBg4oYKzoMhceA6FsMS9RaHVdLUK80WeNtGkYGxvJUXTgl9v7qE
	3fVuboqmzZdUE/o7W3k7WuXFWhDFDz+a2
X-Received: by 2002:a05:6122:4d09:b0:56f:7c7e:f33a with SMTP id
 71dfb90a1353d-57559269776mr7378297e0c.0.1778228757559; Fri, 08 May 2026
 01:25:57 -0700 (PDT)
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
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com> <af2c4X1YCB7NEb8p@infradead.org>
In-Reply-To: <af2c4X1YCB7NEb8p@infradead.org>
From: Tatsuyuki Ishi <ishitatsuyuki@google.com>
Date: Fri, 8 May 2026 17:25:45 +0900
X-Gm-Features: AVHnY4L1KCiaXjNXymmI-IMvyHXcvVitm-UHJb37xa7QDYJ64qIHU29FH7jlFoI
Message-ID: <CABqzrSNDWO90LY6m4AhipDDq5szygKuZ2x_mFEVir_reyaB+pg@mail.gmail.com>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, 
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>, 
	Sandeep Dhavale <dhavale@google.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 673C54F3B05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3384-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ishitatsuyuki@google.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ishitatsuyuki@google.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

>  - using the opener credentials when accessing the backing file seems
>    wrong.  The entity accessing it is the file system, so it should
>    have system or mounter credentials, not that of someone causing
>    metadata / fs data access.  And this applies to all access by
>    a file system backed by a backing file.

I think there's probably some confusion of terminology here. buf->file
is opened with the mounter's credentials, so we are impersonating the
mounter here. Perhaps the commit message could describe that more
clearly. Same for the previous patches mentioned.

[resend: previous mail was rejected due to HTML]

