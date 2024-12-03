Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6349E1D93
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 14:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733232649;
	bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VTH5Vfj50cg0kbyiwVRShX5R3LHjnVSSYwzuxqfxaRlst2mB5Pjc8hASnSqGse9aF
	 Uhh+dMHtH977WWgKxXKkEvkeh1COQO//DkNjF1uCbzZlnHoddXY56fSMmRzA0FhNOJ
	 ZWfD/NX+XrrSyqz7zEC32gc44mBor90/0CUTemRuhvpbTDV4M3R0xdCklkbK2qUfFI
	 BtPqC2uG9ITaZxj5rrhfJQBOUPn65eH6XVromr0HCvOjNuNYnlo5y3NrqYxmE8P4qg
	 kRr0j8h7rKejSFItGgG/KCF5v+cu4PbaPulfjFEt6rWfwzkmEKf/b5PGB6YVj7G1qC
	 Umo4i+B/Y1ckw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2hP55fDHz30PH
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2024 00:30:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733232648;
	cv=none; b=RS/CiBeKs9Vx0cTtOj+L1/LDDkusDqBQWWUVuh7CsTMHHWrv89ULNHNB34VwcxtDAlzHUdU2vU1xzEtLnHnDJbS5T+wTryTonuYjyM7rEFHj+E92ZTMOS4v6ELqWcloMSD6YTt7hc0mR/sKP8NHX/esbjstbM/Ut0i4FMqQe7QiCkCvApfhhCq78K28DlvBVZbmndA87ndx1tXtmDXnKHL5HyJ1fSCz5v0WV9SuowS0C7Fv6ze+Ejob6owfUMkHWf4rxeUZAugJUc+s/Rkt20Q2If1dKo37W0e15m8CEC5aGCH3zxWjZlfUml4XjwD3socWIjtdvmtdEP7/xhvVovA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733232648; c=relaxed/relaxed;
	bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbNVq11nnS0e0sqfma0eRqibV574D1qx8rTpH3iev0sqgJYsNisJMVEj0nezL5xuUE0T9OJwF1v8t4vv62rPbDgKRhGRlGALx3icy3mEySKebA8KJC5ggdPvYy3L+Ow+xUJDNWL7mjxWZaucbKVgCKp11F6jJVpYj1nSI2owi+W5CjNAR+kEGoZUd24OwA5xNAn/TlkF86ZGCJoHNsJm9U1gZKPccgcTSTwxHGrvuEg3iHS7fDNrvc3CQj/g+7pFw/5+Qa98C6t5NhAvnKdyJ+FP+qiWwKG/NuBGCM0wuYmZdqaho9DE6n9nX9MfzAswM7NS82CFKMprcGuhSImYnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=bZ1qJUoT; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org) smtp.mailfrom=ionos.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=bZ1qJUoT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2hP14RsNz304f
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Dec 2024 00:30:42 +1100 (AEDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-53de92be287so8186503e87.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Dec 2024 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733232638; x=1733837438; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
        b=bZ1qJUoTT/Aqf8oEowAg1h6a7xXCI1NF0iO4+Fh2o86ryEI/20fFysk1HnyqdWaK8/
         HcjI8kABpBUGHx5TfoyR41q0gFw73R8VFOkkNuI35Gi9mjUQoVTF0FKjOMlwkf7WODVs
         h7wuexMmP0A8uOSjziU1VPqBXToZ7JQ88xcuZXbp4mw7oZdS0qaFakeBNkfa0x/ZW/vu
         vIFpjh/8JT0iJF6dOyF3DPxCi10PqVEsBuGYj4ZYIRSu1aG0QNRTs4dgpt70Uv6rwFCe
         oyAGg4mCAy6jTDc9Wrise9bwlZwAxOtrfYV96KRfw/bJ6gAkyz03uNPjypoqc/20ZXFJ
         407w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232638; x=1733837438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
        b=nNgGI07RZm06Ow1oGszG2CHsPaAzMKw2taA4/S0xPcPpR6CB03sylLitzTdUzcylpK
         FaMSWJMOkWZr4PWCXtTEKegVRHaMM9QEtAyz5OQgakZVjUH7E25yJjlyvdSqR3JKfGXe
         aWlHW2FE4eK/Mnzx8TO5NcAw5EvFpdP9ti1KwFkhYuPzf3Ay2UcVF/RDMopvwb7Og8aP
         0ERKjUkqkwFaJp7sJ5AyG1KgMmP9C60iGoe35d4kQ6jOGLzDsqcwYHohf1zrCYU6xnur
         ph0aRYKyR92+9GzyvLepb8V6pjsesLDbcA6BsRJDHv/TJ4bZ7/WL26tqsqsVzNvHLHDP
         VRcA==
X-Gm-Message-State: AOJu0YwTyGQ0CbMdCA5lJ7sVogZ1x4YQ3QnQbFpYLpX/yEfdYeWBO4a6
	dD55zGZabP/+v4LrfRDx2NRH1FB2d1DSZoHCpqOuaQzaJzNDV3lPUGcZY+zr9Cvzf5FpGAYvxM2
	hN+DHDfQGZOpAghZb1eDc8ScVwvlLeOB3+8qFLA==
X-Gm-Gg: ASbGncuJq/tpjGLEQEC8uD15x6wOhAB5TfYhvpwVTRMAATT2+LM3bo2IHleGpw2Gshz
	3BG3KH1dtyqqR0FQ4GVtKnuZ00dtsA2+tA972ha5R7Tpgl0HeWUU0PorJmZju
X-Google-Smtp-Source: AGHT+IHzwV0F7K3HmoKIVDx1sWgIm6ncPAPpcRzITTdImU1h90E9EN7eYmf68pN5DyC5EBDpfb0WlM0hv99UTrwJveE=
X-Received: by 2002:a05:6512:108c:b0:53d:e83e:a23d with SMTP id
 2adb3069b0e04-53e12a06988mr2179465e87.27.1733232637809; Tue, 03 Dec 2024
 05:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
In-Reply-To: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
Date: Tue, 3 Dec 2024 14:30:27 +0100
Message-ID: <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
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

This turned out to be a big disaster. __builtin_return_address(1)
instantly crashes the kernel, causing the whole (production) cluster
to go down.
