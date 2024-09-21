Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97997DC6F
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 11:44:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X9kr72PBZz2yWK
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 19:44:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726911893;
	cv=none; b=c/o+sbK2MJACtIMPLsYo9VS6gp6SctxBsSnMiygQDloiydVqaE/o92Z0OK3IMHf9AAUsypJtgts2QbVNP1ArJhIlS9xMBRgQuezUe1Tdkby39WaDlbLQ1tCNhwnH2Ev1of1B3X1LCuzWMWxHcSPLdmerJ8Blmwgip6izAlVrfO7/5qvjgXNSUO9E8nSHiMePz18w3YAgt61VXy6Scfv9FQo8G7AKxdsRGw3QRaxRiAFaWVEdacCWLJ8R2depqJAxsoHzMzsAmDI/IQUKc1HUUSBOwT3eklxMN6S2ts3t+2X78XGr/i1mDaDrPKShpXh7ie2PPwtkQG8oxexfq3rNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726911893; c=relaxed/relaxed;
	bh=iT/pooyDWx+cXonngBHeD7hY6o8n6hEZ+T12BUFn3eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+MtmYzMQeKwu2UD8dE1puQKjOt4+pJZwdKYxKwYRIKDWBG4NYYOvoPa4UgXk/qPFhDgWUsYuYVYnb6B+bdYDPCytfUvGL1MA8nltXlcyOKGdyLBXeyCcW2ifLvKubxk4MDzy+uOoj055s4x2IwHHSnIWCg7OvcHU0ZjEanYtw6qYUcmcSBx4M+y8FpGzUNORTeB2uYHAwpObixJRPzNz59/3sNH0JsEP/EO6DPKuu/CoC6QiYvdhVAICdgOOTgc0DSta8eucwl4XkhkkK+4FbIquFSAlp4Odq7RWnxQk3xtwciBIhBVCabFqkkV9DSgey5DippCirqRFy4AhH2Png==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gZnymtwA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gZnymtwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X9kr51Yl9z2xmC
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 19:44:52 +1000 (AEST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-6ddd138e0d0so25293877b3.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726911889; x=1727516689; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT/pooyDWx+cXonngBHeD7hY6o8n6hEZ+T12BUFn3eU=;
        b=gZnymtwAaAhA26qIqRXCjPHJdLk4o7kmEZWmujNQRAYYtf82BKQKAaTcg2gei/Aqhn
         fOdZztQQGkxZBgCj8ogIg1tddVaZ8WAB121VyhgkmyUIiKsfx5zqu+ZEdvKcHFlxaOIr
         iFpHS966IGfNNTqKqlmuGHVaZuylLQ0FEPpfIa8KcLArdv/xBqGlqXjVRuWnfBLdngeu
         eUFQWa/HmYEHFBTftw8BwIQ/DnUByuR9YJ56VnLt/YKJBBV0Ok8MrowOmKdIN7kQBEII
         6L5ep6uket5sZgwJrsiq4J7Xx56QqO6iDYoay1XtLROTFDZ1LowU6T369eBnwTRaEyx+
         96qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726911889; x=1727516689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT/pooyDWx+cXonngBHeD7hY6o8n6hEZ+T12BUFn3eU=;
        b=ExgCH84NxBlYOzPM9MeB7lrwN4MLKD+6JPx8HZoGMAvppEWmgSXCzwiO/Od+8uMwu+
         PeZJhvaJTM3pqugeuW/DdNO6I7IArlYZOtqQEnNCWlLnQu7JomNoGr/wLJCHE3xwI+zB
         xN/GaCZ3ZLqs34FI/jiRrVP4GxmUdeI4frogb7pwYWV4UX48OUGu0rr3NhrH3+9VuylB
         g0w3iG9OmrhL33SVPvjJkiKTKwEUuRREx9LZVPeaS8cOeil4+2Q8CDRO8jpG0GN89Pwu
         hRYC/oCDdrt9sJ/v4Vtbr5b3HMxk4pV7KW8KZ8AlbqFRzLYldZijo9QLxmW/ZMa/tVoH
         KUoA==
X-Gm-Message-State: AOJu0YzpuKQafvt7ZhoYf0MGmqMLkxuQV1MHGAY8/HltiUu/5AZg6T9s
	cMsyXdOzEEHYZPT6qW+gEn3Wb+eegcOCRH0A9AncH0UBzLJsviB7I+dsY3wWEna85y+k4XdwkmJ
	qivuiMHlMBK5CHY5kH9WLhxfPjAE=
X-Google-Smtp-Source: AGHT+IH7ANdlTlvW/Mj7eVhLgLzw9ibdGPzl72d8JbFblPa9x1BA+ryCfZKd5D4ZNR1894gY3DwL4D76QQESJDYX57Y=
X-Received: by 2002:a05:690c:d81:b0:6dd:d82c:4923 with SMTP id
 00721157ae682-6dfeec1393amr60883837b3.7.1726911889342; Sat, 21 Sep 2024
 02:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-11-toolmanp@tlmp.cc>
In-Reply-To: <20240916135634.98554-11-toolmanp@tlmp.cc>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Sat, 21 Sep 2024 17:44:34 +0800
Message-ID: <CAJfKizpW1rQuVfB3cNKVsEMYvHBegGcy5fgxqTBrr0wGsjjpjw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
To: Yiyang Wu <toolmanp@tlmp.cc>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org> =E4=BA=8E2024=E5=
=B9=B49=E6=9C=8816=E6=97=A5=E5=91=A8=E4=B8=80 21:57=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Add device_infos implementation in rust. It will later be used
> to be put inside the SuperblockInfo. This mask and spec can later
> be used to chunk-based image file block mapping.
>
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>  fs/erofs/rust/erofs_sys/devices.rs | 47 ++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys=
/devices.rs
> index 097676ee8720..7495164c7bd0 100644
> --- a/fs/erofs/rust/erofs_sys/devices.rs
> +++ b/fs/erofs/rust/erofs_sys/devices.rs
> @@ -1,6 +1,10 @@
>  // Copyright 2024 Yiyang Wu
>  // SPDX-License-Identifier: MIT or GPL-2.0-or-later
>
> +use super::alloc_helper::*;
> +use super::data::raw_iters::*;
> +use super::data::*;
> +use super::*;
>  use alloc::vec::Vec;
>
>  /// Device specification.
> @@ -21,8 +25,51 @@ pub(crate) struct DeviceSlot {
>      reserved: [u8; 56],
>  }
>
> +impl From<[u8; 128]> for DeviceSlot {
> +    fn from(data: [u8; 128]) -> Self {
> +        Self {
> +            tags: data[0..64].try_into().unwrap(),
> +            blocks: u32::from_le_bytes([data[64], data[65], data[66], da=
ta[67]]),
> +            mapped_blocks: u32::from_le_bytes([data[68], data[69], data[=
70], data[71]]),
> +            reserved: data[72..128].try_into().unwrap(),
> +        }
> +    }
> +}
> +
>  /// Device information.
>  pub(crate) struct DeviceInfo {
>      pub(crate) mask: u16,
>      pub(crate) specs: Vec<DeviceSpec>,
>  }
> +
> +pub(crate) fn get_device_infos<'a>(
> +    iter: &mut (dyn ContinuousBufferIter<'a> + 'a),
> +) -> PosixResult<DeviceInfo> {
> +    let mut specs =3D Vec::new();
> +    for data in iter {
> +        let buffer =3D data?;
> +        let mut cur: usize =3D 0;
> +        let len =3D buffer.content().len();
> +        while cur + 128 <=3D len {


It is better to use macros instead of hardcode, like:
const EROFS_DEVT_SLOT_SIZE: usize =3D size_of::<DeviceSlot>();
Also works to the other similar usages in this patch set.

Thanks,
Jianan

>
> +            let slot_data: [u8; 128] =3D buffer.content()[cur..cur + 128=
].try_into().unwrap();
> +            let slot =3D DeviceSlot::from(slot_data);
> +            cur +=3D 128;
> +            push_vec(
> +                &mut specs,
> +                DeviceSpec {
> +                    tags: slot.tags,
> +                    blocks: slot.blocks,
> +                    mapped_blocks: slot.mapped_blocks,
> +                },
> +            )?;
> +        }
> +    }
> +
> +    let mask =3D if specs.is_empty() {
> +        0
> +    } else {
> +        (1 << (specs.len().ilog2() + 1)) - 1
> +    };
> +
> +    Ok(DeviceInfo { mask, specs })
> +}
> --
> 2.46.0
>
