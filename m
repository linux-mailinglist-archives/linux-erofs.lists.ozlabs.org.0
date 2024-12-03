Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764C99E1577
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 09:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733214037;
	bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jSpF/eHuZmLdwhexaXaPw6dmKgKEQCjlJ2XsrDW7i4DKMe9xVmrPis5hzkNv+nzi/
	 lc3Ej7Bfe28TVq+9CFV0EgFqoVdhTY+BKrwuwrWcwSK6Inrl7CBk4Y2HQ7rhQU8YIP
	 kaDayMBSS7HQbWNM0hSGjkxrP0BXCH2HoKhBOcVNS11/xo023U3lsLwp85c0eB0EwD
	 fsadWyN6e1KIZKgh8IDfl8/EsQk2cZId015PiPAfixrI5CzzeDZYKjTUWRzevEjo+e
	 9vMeLtAtKvJsUW5W3skEulXwOuVKZYDUF/FVom0AkcwitzuKN4dyDuRIVXjzmgF0uZ
	 ylQ9/K36BVn7w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2YW90Nsnz304Z
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 19:20:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::135"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733214035;
	cv=none; b=DtfqPpV1kEwoEFkxqUg6B3wAvdXx9QzkHgpRm1Y0y79MhhOUeUkiRm3ZpSEQAGi2XRNwOrGZ0jM9SVxULUOunK0o7tvUI4ig47f4+XG2qUY++KYAv0CdMuOptn9DnfZExLsj4rOGlbymBucRIHypgczjmGzzx66HVhO/TwMzME88Jp+G4kbObqkCvJBuZ2CAxLUSU/8/RxTcX3NJkJnuj1ztqDHo1Rg9J1MT7/00xzPMYsxgFkjX7hOVxFweu0BUJDn6KwB2PQRTFrXhUjg2HmyDXEcHmvfQNXXwW2ITTDYo5vsaUJFFGVEYvN4mqbdpMPPOfWh4jeclDKYDbuHUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733214035; c=relaxed/relaxed;
	bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM2H54Egr/WVN6iqj1QfW3G6EFHDInYZH711GYjmYBkiYJ+EqIuwTRZE2QUJPhdsGdqjiyrWhOlvuhi3s3P4/C1KKJEqqYoNmWeNlmgwmJdPGUGY5pSuKMcf2D7VEnu8KwqWg5uHUZWx3hXKo+WdhcIdY/ba71oocaTaVwgP1M4bHU0Gr4imXjfpDmdPtcT8Ma1KB6qvioFOHv11mHcHSDgfl5pBBPUi5es2noc520re7o05/TjZhDTiJIMmyVzzpR8gjsjneiqznfcDVZgBtDW5DWxKS5RDgYyKgJqhJpC3yDB7+oBrv/Th5CbjSb1M64GCfOjTm/a+Xos8ijzIjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=XhlrAgKj; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org) smtp.mailfrom=ionos.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=XhlrAgKj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2YW52mckz2xfB
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 19:20:30 +1100 (AEDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-53de579f775so7246946e87.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Dec 2024 00:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733214026; x=1733818826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
        b=XhlrAgKjizhxnsbEvrCRVsM0COm1sFzGmhMTQlL2Xch9Ekuq4Z0l9xe5yPpeQ0o9j5
         0EyVWr3wlblCkZktQ2mvv1DXcmqw31Rfsk773wz6bpuO5mKLpOVMAQqm16BCM8zKYIX4
         hdicOtMTqXpmoGLKq6YaktL1+eWcXYSXC2oe0W3YG3zt1WSJ/jgShAMJSTXFkEVSQ4y/
         OPpUQbCvxxHTiAup1ZzgefxNacDVzbv0IJP4oOshq3VQA80u3TdwEhEXh2Zvj5UwYOpb
         D3p50zSWxS49fRrMACJXAi4MZ5x0+G12NKtOvwig8LOYIqFLzRO7i3PTFtz7Dj3GEvgC
         ABXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214026; x=1733818826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGJkap1WTg6IueqDR5QNwSv0nTBzoV76mMuGw6Sl+JU=;
        b=Mn52Ntu+G+ZICyLZlLHkemwlHpG8zGwIan68KpLzKug/73DE0XlNlhgmwKTDA4JbFf
         z6pvGsNzR7xI+BuhElRK2k8ICYiLQQbLRrHC8ntp/d/MCZFBphnoxVGRmV8akISoStVW
         9Vjd2eSWN+gwZpFEvcafnpssBIuywBkNTMmXDjiv776QIWOg8rJrSrr3yXzUPWHDJ+Rs
         vfQ9OodIxYJPXZtxENiiAdN/YPn8BbsxHukWEvTMvL+WriN0I17yiy0q2nhsz1cnG/N3
         qzGuCymUu3+yloDDAMmCPOPMnH4SGIyX+lGF5lGh6yL5RduN75cQYihhtjThzKO8pau7
         HxQA==
X-Gm-Message-State: AOJu0Yw4T24oB8WIq3/aBxcvOYNBtvd+AYPiTHAdej8f/OOfT8eFv8UX
	Y8C/HB49YvpsEXXmBhM4mxeTS10NNAwcktjmhU9I/OwILZLWo1B8KNPx9YUHGKG6Cot9uML08dc
	HMMyp0q3wsVsAy5fa4hT3ysTzvLvWJY9B541CnA==
X-Gm-Gg: ASbGncuzlONTzKS/s1PJMG5KPJs/JbXkigDTTDmV+9ZDUlqyZ6r0/N69vEYuUpqjUAs
	0blBOV9TLZVys1HvlX/gEnuBN5fMO5wd13Vfcyc+1VbOlj9T0uqApo2xyk1Yb
X-Google-Smtp-Source: AGHT+IGv5j81UR35BUm92BdCNXhtAfGCp3+txElbTevIkFrX0dXOOEieF3S1EHxtB+DeutvtSMJ8LVptI11DRyjMDsI=
X-Received: by 2002:a05:6512:3ba3:b0:539:8f3c:4586 with SMTP id
 2adb3069b0e04-53e12a3930fmr1166092e87.55.1733214026423; Tue, 03 Dec 2024
 00:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
In-Reply-To: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
Date: Tue, 3 Dec 2024 09:20:15 +0100
Message-ID: <CAKPOu+8=ys1YMvGhmqjCru76jD6qah+0JXQo9-ChqhD7YxEavw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Max Kellermann via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Dec 3, 2024 at 9:15=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
> But I guess you could record more frame addresses to get the caller
> of readahead_expand()? e.g. __builtin_return_address(1)?

ok, I'll try to figure that out.

> Also btw, is _RET_IP_ stable among all cases as readahead_expand()?

Yes, always the same address.
