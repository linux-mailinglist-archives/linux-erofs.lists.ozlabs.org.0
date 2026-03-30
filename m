Return-Path: <linux-erofs+bounces-3089-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDmPDCr/yWl64AUAu9opvQ
	(envelope-from <linux-erofs+bounces-3089-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 06:42:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049D355550
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 06:42:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkdrk2LLPz2xpt;
	Mon, 30 Mar 2026 15:42:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774845734;
	cv=pass; b=k8CN2Qvx1rffbipwMb1C3WDsVoq+4KYcFzlB31Po076v4skQC8fcSMfeNs2mHz8+AFkFRbgiwbqIge4L73az9j1qWTsNKt7lc2CKZR3BU9RV3RyDnyKrYTPN2swrZ+NsAfDuN8cDKOhuz55l4GzJLYI2LtMhiuOw07C4xm13DgVPc4s+b6c2kU3RUjRU7uAATuKhEUGK4x997RnIJSzEReWw4dX5o4hZihOKcipk21ZXrC//KL2R//AVKcPiODjf7wIxUtG25FGaXtRk+xYfDqTD9JEsGu4yRHUraWnM3ybUdtS9LmjrUvNVxPOdg4y/shjRAVJzHdx6YVN5qDjLzg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774845734; c=relaxed/relaxed;
	bh=QltIoA980QOT3QuaKdYMWOHGi5+FgYCSAqzUshYaflk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecaaEOh5Z8/8ozCIEN3a+QCP7scUFlXuDBebaPanBoBzTP9Vj2U3onH0wgr+MANPYm1hlUj1+jCN5rEFsWNh8xe4L0Rf9DBAKOpEwJgJfNf4QxVzBy1meALB1HUxbyQ3ep8RTT1/GV+27F7SUz1d9vIVz802oFxGeDNf6NfuJqMOO5oNT7NdCdq/HWahqZgyV5GuYVNWcoh2wd8A+C6BGnnajrNmcUbDJgKKgocEILMW5LE60UQs4fENUsrWYAiR9dMKEpY10xO9ihzbm1x3KB+Af1hGcZ4FPX8j0eVFL2OdqsPiTrc5ssguVceFoOjn5Y3kAokv6z94GX3VDe9AXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KgAK3shm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KgAK3shm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkdrj2DgGz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 15:42:12 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-6500040f172so3532036d50.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 21:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774845730; cv=none;
        d=google.com; s=arc-20240605;
        b=MBJUoLuu/vbCh/SGniH28WMBYK/+ZJXhikLgt//8qtNyRI0U7hj1oME7UHTxWxv3tM
         SA/7B4FJE4kPGl79PvRgyd3PuVIbVt20M1vJehTsM2EcULGJT5lDgxfMbCLSgzXJ6LVJ
         kVaLFzWR5gOuymlHPSYtLpLMZ5pGmAfZjPXFQqv/0+VLtio+OeNn1gyH7FMnsTOKRloc
         DxIDEl4+vWIODvj8LGKT90vrC+djC+3ZRSVjAmU/X5rWqEMq1xhrcEiWBSshvd/tgdTR
         M5E2hf9AqWehT+FEPZZzOjG5SUq9IqOeWnSjnQPiYcB9S6RQnAV/WFKU/q1oA62BX6In
         uklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QltIoA980QOT3QuaKdYMWOHGi5+FgYCSAqzUshYaflk=;
        fh=BgTUGnkfGYjFeqSc+TeG3W8pj2jEftgQcsnynrItmPg=;
        b=SnBKAUbKwKBXJcGUzjmCF5MEWbQ/up//o9ymeD8YRvnMvZBEe3x74rPyKBzHDU4tVv
         1t094iuwz3/0MjaSrcg4PNy/zLpLBIYCw6ZQkjek2AtZNtw9iSCCKcFUs16c2eH1Ywcz
         6vD0NtRm/HogNlIZMO/T59TYuwMa0QTxX6z8CAwBdJAv6hC9Ge8iYbq/fQPtPD2LLinp
         0ltYE+yJE4uJAmW50MN4Xpk9JW9uWNV1dA2TSY1aOa1u8Dw16ArDG3u/uyHK87sCTda+
         v7pEeh8dErGqUVFdhOgUOXN9rrr1JV44qGLeePOjStehJm7lAWDjO64EJ5DzbEfAK3O6
         g99Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774845730; x=1775450530; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QltIoA980QOT3QuaKdYMWOHGi5+FgYCSAqzUshYaflk=;
        b=KgAK3shmKjJRDwKzNikoN678y+BvCOfSkyXRuFHPDZT7afORxoe6WAgRGBtNP0XyYV
         TOR2GA2kBW2ppeVHt3Nsjva+H/DJdH5LLrBzTxbj3qY+ZFuX12s2enxuwVLXSeLqjKcZ
         mL1fakotOMd4B78+Vu+eRJFgFtHp5NAPaTegVXI+a35xXAmDzUFa2dQhxEhV0UeYsRb9
         p648MwOSecFx8+FLwBhR6AVfWKi/LWEchieBV+Z1rXQ3jhoa/aJGhJkj2PS32ElisqPh
         47znAX7OVMPSgiiH+x/rFu8mlTh9bebt86J8l/a1DualBQehHejc5oUogy135/lriC4a
         nJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845730; x=1775450530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QltIoA980QOT3QuaKdYMWOHGi5+FgYCSAqzUshYaflk=;
        b=VfJcNosU17Vejz/fwisIrN+Nqs4RGIifJ8awifLAjgcln6qQBIpeF5CAoEsDmibhVp
         cBlePcvK4PfcuM71Pj9nARXcOimxKe6WAVuOSep/5vGVMYtDwCJ8nJ5y5OjvGRGL6oFt
         05AoEYEDkysDsI4JPTS74TlcRbAVztafYWfG3SlJjhfulCwqernpYjWPuQUntHXSoJu3
         9kI2Rv0qHpNp/63UdueNcTw4XtG+nzJfSlczVHRmxwjB/oPQbvU/JZgYfXgqKEvzgLDe
         veFWk8CFrCZGAOr1MNkpwFB9dLjwgdVsR/HO7J7wCFvzNR28M2EoWilzN+hfn/PdfM21
         IkfQ==
X-Gm-Message-State: AOJu0YwnBOHafiIXghzlR+nIhH5X9UQS7kM1IUeLIGEUhiFTjEs8CARI
	B+FpF8lBTSbTFxvJVFrSaId3hPSSIbQgNIzcpOEOrK7J4us7xB+XymLf3tF9YGepvb9bAiX7xgJ
	C9ZkJjdlKYF9aEBwO96nwtBx3Fr78hhw=
X-Gm-Gg: ATEYQzx2l3dqueQN2KEYe+JEP78sesm5y8b4p0DFKiBpeFgbi/1WLyuiotuj1kKQAQH
	a8suY/GfARoMgm8CbHriSxMnRYXAX64XLuz06+57oB1C3tF4keSn3KRvmmNScWdd0B7heN+Zqu5
	GrbX1f02nPcAAMakow6KOYfgbe+CxE+klT2Lp55nlNUaeSxQs9diXgnwAH5OGOQVmUmfPS3NkOx
	0pcS5l7BADCSKLi7MnarCQhSo17Wk0fWWvkG34pP5JrRJOW66vX/6q+N61A2LLZYZfANlLWwTmB
	6h13jOY=
X-Received: by 2002:a05:690e:140b:b0:650:16e2:2976 with SMTP id
 956f58d0204a3-65016e22ae5mr3421402d50.36.1774845729937; Sun, 29 Mar 2026
 21:42:09 -0700 (PDT)
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
References: <d8e7345e-a1cb-4234-b03f-a3089f7a1c27@linux.alibaba.com>
 <20260321071542.80503-1-nithurshen.dev@gmail.com> <a2c19923-89fb-4225-a468-b1629cc07328@linux.alibaba.com>
In-Reply-To: <a2c19923-89fb-4225-a468-b1629cc07328@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Mon, 30 Mar 2026 10:11:59 +0530
X-Gm-Features: AQROBzC8GeL5fFyweyLJ97cKw2boFCJOacce2mQ4odxgbZL51g5nC7f3T1nug04
Message-ID: <CANRYsKhN0kygJRnvrGpbCJWxYU=7VyosFbwbdiU5cWPEFzGJiA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, newajay.11r@gmail.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3089-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2049D355550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 7:09=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Any number is fine, or just use 99 when submitting.

Hi Xiang,

I've just sent out the new test case as erofs/099 in a separate
thread for the experimental-tests repository.

I verified the test logic in a Linux environment; it successfully
triggers a segmentation fault in the unpatched FUSE daemon due to
the double reply, and passes cleanly once Ajay's fix is applied.

Thanks and Regards
Nithurshen

