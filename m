Return-Path: <linux-erofs+bounces-2542-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELG+G7rErmn2IgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2542-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:01:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D5239573
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:01:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxwd40KCz309P;
	Tue, 10 Mar 2026 00:01:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b132" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773061297;
	cv=pass; b=UPm9ySw1q/0py2QWYpV+Kt1Yvf/PQv15uuqNII3r4HkrT7fxx9MJqw4EypeW3SECY7wFH3DAmfo5/4EgdoxwNmQJ6QkVwgn8akTI9HO/j+wwRTeXvaqTmL01ET3khfRBSARoWWOvASITEUwJNcG4yOpE30jggLHVc0emWyUbJgkRIe/C3t8MmNMKXplbGELwfz3zey7oWNNAXR4WkEZ41FlSAsVV3GwgPExmpv1iPcEm7dFtUvSE45IM4EBDpzQuWam0q0s88JM0NbmaBTtn4tMDiGY0HioxUap0Ywglh5i8IqMKPij58A39smnFK3U9Vyx7OPuKRyY5O24k7PiieA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773061297; c=relaxed/relaxed;
	bh=RT9ABOCrv2b90UculvmYAdBROWCE202V0hh/BKd2RVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLKfL/WpLTS/7wG2SSe7uBRsmKKZiOeWgCLlBxdH3pE4cswwvDlWBVVCGSb7f0INwmaCQdrfvW7jNXhGxOeUBqDaISBmamVnTRuwO5NGTaKATSD09ijEuTwudf/0HyauyVETy4/LDWOsckHYZOUEHxMm4MnZhCA9ahxVw+iSr8TlODjm1LJrqhFI3YVds6+foYr9VRPSc/VWjL/cuBxzH86UHlS634SBu9O6PkDpBo617lx4h2Bxkxj5CtQrPh5VN6Uw2Ujqtob9n2ubQ7CzESsltG7mpt+rNokpKFzxnPB9hYFVyXo40g1h7tQvB9rqnDoFbyCkYfWy9G0nfqUTrw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GPFaPjBU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GPFaPjBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxwc2xDGz2ySb
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 00:01:35 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so9870902d50.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 06:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773061293; cv=none;
        d=google.com; s=arc-20240605;
        b=Ijsv6jHnK5zuv3Bk7VnJF4G2XbFDASUu9ygymY8LiHtQX9FWLclbLwdLeT5SVdG+4k
         0A4mIujnI8H7Eh7g6ZOQSoVFyigXCiN9sFpju1iXXvgBzI3C2X2et7Sof4nkarK6rMz8
         /PTcNDHyvzKFvueoEYmAUn6aa+fxn/Qz9JdQ5N7gGQ7fxw2Giths1oD7aXwXRTmMaWsu
         s5o043GzdHDjAUp+0Lu+YhHylG44R4+OryuJdYmJOXTgQTgy3NoYwOul/4rqcCDLaOFb
         jKO6N79E1U7Yl3SZVle61qdDrPupm/FEoeVFOvguhDgrAsyKW0VyDVDALM75gPaPVok0
         7jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RT9ABOCrv2b90UculvmYAdBROWCE202V0hh/BKd2RVg=;
        fh=nIKi8NVDsUwW90vkCadILubuePdqWFgBCWsmY1vMOnM=;
        b=kpxz3jnDIHciBGDOkgQ44xkPasGSWQEe86INlgLyD3AD7Os9EAQRdclzDGp5QklNjz
         3bwPsHB6uY39hfqAPH/s6IuqO9q30CwKXfCM1hX5/p205eHgoCuYUjESQ4Ro2164b/UG
         408Zcbl42YWadUXfcBo180FTUReDoaBU1kQcSkLm5Aum8+l1O24tNLZQu4usEHgz0C0V
         IRdhOZP0ewL+5SfHRnCP5p5wFbhpFpUMnhFIdVG/K9P63T0mpWWmQeJY28eXNWXmlcvS
         RbkMT2fQICFep+t7goD8XAygZhKXWCywIUefVy0oQtEMglnl3JbKkvNVXBxTanlLc/wB
         VeFg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773061293; x=1773666093; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RT9ABOCrv2b90UculvmYAdBROWCE202V0hh/BKd2RVg=;
        b=GPFaPjBUkiyXJeNAUNtWAlCevmU/wr2yNtKsZK55By9+gmob08NrfXXODmY46UFr09
         PGlPj9/zz1ulljf/D9TrF1OtvjLe9HJMpHbnUpffsbK+pE6hfPlwZ/jB3bZq7GMow9we
         ZKbCaeKy7jV5jcPApkfOOhLp4Un2P743GHXwXPFOtXOFjRsttN+38yrHp7jMageQkJcr
         6hDnlhGChyktPF4VpEfJLk/paA9rlHoHYQGHk5qOZnJl2SM29M+6t2Lq+A057eVisuaL
         /5oPYtIVDcyk4+wGrR1KYy48IS31xRcZ2/dS2aQdHz7ZCiT9HJRBssj5kHpjSimjzMjm
         Ej9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773061293; x=1773666093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT9ABOCrv2b90UculvmYAdBROWCE202V0hh/BKd2RVg=;
        b=gEluh785u3zlKQtfiAYWiRwvM85/WMqBGHrGwqXis+e7/cvqzeRVmJZtYctFCUsHFS
         KRkY+O+BJOFdDBGWjQnH39ushhQgRzGzEiD554iMnJ+KSHm/VNT0tTuNRqspeZd7ZPxP
         awzpGY0sZLshVaT9fDEt4irrVWnPPjFRU5bY71VcADx7KCSnUqk9F1PKXfuClKyLo4D5
         OB0fRQBngJdkdhXFPR/Y7BzqpDG9wUSthEEHKVRm6Ralwr3hi38E+aWeeS3dr78xC4Cz
         HvTvZppEK0h5MQufxXmshSavyX6OvXWjCqBdMGOsfpXqYa1zLlPCTMt+VEkviVOL6O08
         vb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8X4g4d9CCPH1qPJJ5LVFVj3W7WgxD5P850qN4vueKBC+TX0n8diVhQ31RaZxbUD6MJsgHpDsD36SF1Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzomY01FDalCMV9FPURyNJ1MDp3SwKlJJj7N2p2ETmTnp6wN82Y
	QyEOB7X5ebLiDOWgWrZ1RO8cq/AukYgBzeLsjP6v8QcuZG6zVS+wKUhpSan2CQ9IpWSv5P/3E1L
	UajxbO10uRQB/7mVmlrCm422Cezy6laE=
X-Gm-Gg: ATEYQzxzTa12r3I2ywO/DlXn4WL8RLV3/IWhtTaqvw2I5j5LJKkN0ro1DnvKo61SQi2
	O8ZFU0lrvaQh5DplA0isMosmF6Hfvj4XfjM6mIGVKE/fybYkUgh/0dhp+CvKE7+yna4izL55W8h
	z0cb/NAY+aXVF5ptifMmmuKt4g5p6+o2HbeSy+qIOhyNLS6Ap4JAVXmLJhcNeJPyg2I8uNnhnE3
	XU0fooXjximizRaggQ5fMJ8m9XFffX6yIGKOxwi25Kv63WDkswLbfPpcCAqiWfsuQWAWIHA2Elu
	67zVeoo=
X-Received: by 2002:a05:690e:1245:b0:64c:ed3f:ea3e with SMTP id
 956f58d0204a3-64d14096703mr10256342d50.9.1773061291647; Mon, 09 Mar 2026
 06:01:31 -0700 (PDT)
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
References: <20260307062810.19862-1-nithurshen.dev@gmail.com> <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com>
In-Reply-To: <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Mon, 9 Mar 2026 18:31:20 +0530
X-Gm-Features: AaiRm52Ah8SbWsSx3PVQXqtuO0EoYNq48Kho3DczUKFPmKoScUPieMCT1e9uFNk
Message-ID: <CANRYsKjFzXQEttdrTKv=ZGFmbvijQpOhHGteQEKMWnwJ6ykZDQ@mail.gmail.com>
Subject: Re: [PATCH] mkfs: support block map for blob devices
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 607D5239573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2542-lists,linux-erofs=lfdr.de];
	ASN_FAIL(0.00)[117.38.213.112.asn.rspamd.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Yifan Zhao,

> Hi Nithurshen,
>
> Each line of the commit message must not exceed 72 characters.

I don't know how it went wrong, but I will double check from this time.

> It's impossible for 32-bit block map entries to support 48bit mode.
>
> I think we should err out instead of enabling 48bit here.
>
>
> BTW, it seems the erofs-utils codebase could not read a chunk-based
> EROFS image
>
> with block map and extra devices (but in-kernel implementation could),
> as erofs_map_dev() does
>

I have taken care of this in v2 Patch.

> Could you help also fix this? If you are
> interested please also add related
>
> testcases in erofs/erofsnightly repo.

Sure. I am interested.
I will work on it shortly.

Thanks and regards
Nithurshen

