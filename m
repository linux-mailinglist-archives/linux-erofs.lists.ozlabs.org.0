Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11B6E76D2
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 11:54:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q1bjm28cZz3fH5
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Apr 2023 19:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=JBt7BWpE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=o451686892@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=JBt7BWpE;
	dkim-atps=neutral
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q1bjf39Jxz3cFw
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Apr 2023 19:54:29 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id fw30so27267919ejc.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 19 Apr 2023 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681898065; x=1684490065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh5Bo++ve6b3PGYDI4243NLEc2G5pQruq+xPHsiLyRc=;
        b=JBt7BWpEQFcrg4Nesf00vkKvgwXRNKM+4x0Bx+zbyLENppXCy3S79OVlIvqM7j7oPg
         BFzK5LUKA5LcPg45sW6yt/2JWa0UXTg7YWllUbu184zpZpivaTa//mnR70dlialyX6pq
         92XTIVD0ND4RxDVe7ELVvj2zoKuX2dWNVj+f4GI2aL73sa18/8yvwSNdLufhTGmVBHlS
         QhtbRmhI6Li2yC9zmwCqhZh5Og7hbvlwO9CwpYjWLdimqjxJ6GLxPGHkHS795iGco7+P
         Nz5V8d2zwaeLtFummKuaqNYRZaMdeIhiiphuCJM1I8YNt1SQz4nfuFDjIrN80G7zkcEf
         6RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681898065; x=1684490065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh5Bo++ve6b3PGYDI4243NLEc2G5pQruq+xPHsiLyRc=;
        b=hodqa3c9hge/Ig6R1TRn06+zPLd02km3mRiC8ACLlVzFs0HYRccEcMUuM9bmRGmpCx
         X5iPACe9gD43V3yzBSfWQV396TkgwuDyDsVR4NUUL2LTPxsAsHuSOP+GMGb2rQf1MvrJ
         1M9nZ+ayy+M7wic0c/quW68sIvUqQZBLwYCrBJTorBRu2Mlz0+HyPoITobp46hG2KVv4
         CQ2c4aHWkq5kNlg/MTFdmEZFU3cudNNWNKTLBcyMWKWctBKQEXjgf7u8bY+xalEatOyu
         WN2KuoviJuTe1BLtRqK0d9xLyOaqND97zA6dcShZz5aF18yi9IATyJq7WChUxU3U0WKq
         +SCQ==
X-Gm-Message-State: AAQBX9fuE+z/l5A+3yAPDPh9EPb8wSj6oV9LGUd618x3ElGrW33kbGnv
	PtMLs+e0lJeC3tkVKYZLxNqNHJlRxdOLqQugeWC3VJRR0YP7Kg==
X-Google-Smtp-Source: AKy350a87kM3kljI9PiMwL+vg8N1o/xxdZ/R8Uj6WHA+ILlnMr2C1gb9BaE9eEN3oxX4QFo06S1NOzUiRRbfaW2GF1Q=
X-Received: by 2002:a17:907:7ea7:b0:953:5ff8:8b1b with SMTP id
 qb39-20020a1709077ea700b009535ff88b1bmr451559ejc.1.1681898065096; Wed, 19 Apr
 2023 02:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230419085609.6601-1-o451686892@gmail.com> <c2ee08b3-1f6c-3fef-28a0-6b31ed1957d4@linux.alibaba.com>
 <34f622d6-2bd0-9b64-013f-925df8e90077@linux.alibaba.com>
In-Reply-To: <34f622d6-2bd0-9b64-013f-925df8e90077@linux.alibaba.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 19 Apr 2023 17:54:13 +0800
Message-ID: <CAHk0HovNwr5T_iqeW2AOr4vbaJYVFxgrSfyd4v-7qBTuAR83-w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: xattr: skip NFSv4 xattrs building
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 19, 2023 at 5:05=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2023/4/19 17:03, Gao Xiang wrote:
> > Hi Weizhao,
> >
> > On 2023/4/19 16:56, Weizhao Ouyang wrote:
> >> Skip NFSv4 xattrs(system.nfs4_acl/dacl/sacl) to avoid ENODATA error wh=
en
> >> compiling AOSP on NFSv4 servers.
> >>
> >> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > Thanks for the catch! Could we ignore any prefixes
> > with identified "system." (but a print warning might be needed...)?
>
>         ^ sorry, unidentified
>

Ok, I will send a patch soon.

Thanks,
Weizhao
