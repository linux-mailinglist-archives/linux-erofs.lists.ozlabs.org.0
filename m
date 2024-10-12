Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A631399B4C2
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 14:10:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XQj4r4vGfz3byj
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2024 23:10:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728735051;
	cv=none; b=RKoB1p7UqLSzHI07klhodhKzH6zag7xTKuFrylA6Q1DU9GXlfWBEZu0uZt4x6k02dTh7h3JO+3WDqCgQ0edWcTFXxZwvVtT04C891mAwaJp/2Q3ZAV0hkxaO89kwtPqF7XVEhEteMYHrlpvQP1w6rl+IfCKlxeVdFhAdhdbHhr+6zns1Xp+BWWxnvcTZMV6CgD/0iWb84hXMkosnQIex7f9A1fN+89057PkgtdYbOf04xKlzIpsp72u7jyYn0v9oVL0zB5008m0V0JWUmxGOQ63lKUQMZc/uBi1LAPz9v7jXcggWvNM05FCzUq8IyvfybC8zune4/s7n+BB40fZpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728735051; c=relaxed/relaxed;
	bh=mRLKjeT63YCXr2Yyng+u6JlVIQ5yaQ9iKIDqgI6GQss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbRJ+OxuOz6R6cEP6MmGSc2PKWglu6wD00xFIsmt24htC0FJ8GktCripmoqeKsxqeLzSntQ0+AhcArPSN266PxiuVH+mm8Vk+3GChWqtNUXhiaZSh3sRPeyB3XCgVo2kj8CIPGDGohHhPx5ss2yGvJtKmOXCSAnhJNoSvGpnSUduANNsG8SMmk20A/clpVDV3SiCaywVFgceWhY/EMEKqxkl1RYF7d5A5s316eUPrVuVtkkLy6Ngm9x8lPuudFLqsAhLrN0askw54Rn7X8ZQVLXkGuPukL4ym60an61IcgS9Z2oiQfVIUNBhAGKJMXq88Q3ebV+lcvwYMngcsVP6wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XrxlHyxx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com; envelope-from=fedora.dm0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XrxlHyxx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com; envelope-from=fedora.dm0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XQj4m6rKHz2yNn
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 23:10:48 +1100 (AEDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-6e30ee6788dso25558437b3.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2024 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728735043; x=1729339843; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRLKjeT63YCXr2Yyng+u6JlVIQ5yaQ9iKIDqgI6GQss=;
        b=XrxlHyxxQSRILxFXfLRigMRlQWt6rXhjy8dy4GwL5ZvVndhnyu02gbNJmIHvVkyxuF
         ZFuwp3sAA8UR3rIsRMZyHCkLjWEdNhMOZBXeQbYHcXzGF1p67ZlA/9am63RIjNQwJ4Se
         U/AlNg/j0LFcsUG+Z5cIDeO3HCZb6Uj/AEIZlu0HkvRTE7HfD4Jtq6Rmea/pzHZgmclQ
         LzceS9558RSt8wJg/WSM8n/bF2oyAtI5B2NJQdErE5J00Pg9mfH4Ij95QdywqpVteZvc
         xTkCqqt2OprN1CmwijENDEjvrdiWm749W9EGtle4utgwBcorNU85qViLNOOmy17xekmw
         grMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728735043; x=1729339843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRLKjeT63YCXr2Yyng+u6JlVIQ5yaQ9iKIDqgI6GQss=;
        b=j+j7XPYQQxUgYPUvIP0Y7Z97Stv2Kdrk4kF7MJ88UdQujTgYIamId2qjgOxnVChX4I
         gN0R6Ht+vZz8q71vqzURWl21qpgfuOC0RCnpmVdoCh/0/RerW4Se2VahlaUZiXwzlJ9x
         DQZ6qvWjqGrWhefYLujJG7EDCHIb9OcQyt17YvAYyNaW4cg3voqdNoFzFUZvHnNQVDCH
         BPk/q8fbUXr1nJFa/TfaUlgV21aE1sfRJBFRMk99/Y2hcZkA2z95FezrTvdfzFx1RzaH
         NVcfeqDfJEW3+tVU8ol7KukG8T6ey1c85G5MSgD4YocAuYEl/8+6M1bFP+ODpjXvpz01
         aLag==
X-Gm-Message-State: AOJu0Yz321g2TlIOmdryeOS7Ai/G+tralOGfsPleTEpZYTxa40kD+DhL
	XF5l7ZM8clw5m5YqztYyuOS/CFF1y0X713C+pJXRZCLub02ckceQOB77dXblvHcfnn/8yyXDxPx
	cc5cVA+9H6GhNBjV2abZIKxVbKKS3EA==
X-Google-Smtp-Source: AGHT+IHYJ7JhKJaV+/BOTI4uQqg4bTarAYgNxRdsjcQoMv3AxJrsxCVLY/8VaoW/mKMLuIf6kpPqq7kGPPMdx7BD4tU=
X-Received: by 2002:a05:690c:d92:b0:6e2:aceb:fb47 with SMTP id
 00721157ae682-6e3477bad8emr42063527b3.2.1728735043503; Sat, 12 Oct 2024
 05:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvUa7njGB_7Xs4A+DhGBR0LZL--tAZNmU=3bFS+uVm0G8uULg@mail.gmail.com>
 <df3200b8-4fc4-4db3-a112-2f963a263b36@linux.alibaba.com> <6076d690-9b69-4821-a0c8-4172a4f47c9b@linux.alibaba.com>
In-Reply-To: <6076d690-9b69-4821-a0c8-4172a4f47c9b@linux.alibaba.com>
From: David Michael <fedora.dm0@gmail.com>
Date: Sat, 12 Oct 2024 08:10:32 -0400
Message-ID: <CAEvUa7=6PkPLhX+jq2SykD95j5XSHoPC=yu8Nkf3_kgOCjsCAA@mail.gmail.com>
Subject: Re: [bug report] erofs-utils: Compression with -Eall-fragments
 segfaults on 1.8.2
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Oct 12, 2024 at 12:35=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
> On 2024/10/12 10:05, Gao Xiang wrote:
> > Hi David,
> >
> > On 2024/10/12 04:22, David Michael wrote:
> >> Hi,
> >>
> >> Version 1.8.2 has a reproducible segfault with "-E all-fragments"
> >> (testing on Fedora 40).  When compressing the install image, it
> >> consistently hangs on a firmware file:
> >>
> >>> sudo dnf -y install erofs-utils
> >>> wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everyt=
hing/x86_64/os/images/install.img
> >>> sudo mount install.img /mnt
> >>> sudo mkfs.erofs -z zstd -E all-fragments erofs.img /mnt
> >>
> >> If you isolate just that firmware directory instead of the whole
> >> image, it will segfault:
> >>
> >>> mkfs.erofs -z zstd -E all-fragments erofs.img /mnt/usr/lib/firmware/n=
vidia/ga102/gsp
> >>
> >> It happens with all compressors I've tried, but adding "dedupe" works
> >> around it.  Is there any change I should test?  Let me know if you
> >> need additional information.
> >
> > Thanks for the report, I will look into that.
>
> I've submited a fix for this,
> https://lore.kernel.org/r/20241012035213.3729725-1-hsiangkao@linux.alibab=
a.com

Thanks, this does fix the issue for me.  I'll apply it to the Fedora
package unless you want me to wait for another tag.

David
