Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAD81F395
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 02:30:16 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nJOUFErt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T0rY20DJLz30g5
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 12:30:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nJOUFErt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T0rXt3G0qz2xQD
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Dec 2023 12:30:05 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso2617628b3a.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 27 Dec 2023 17:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703727001; x=1704331801; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYb21apCi1TYD3rMtdP8WfHi0WzC/HMdru5c9HRlZNs=;
        b=nJOUFErtQPWRMfCMBbpjukwGeAX5c3yb67pXemFvDvOgOW2YmdCBjgXNjskYMlHA4k
         EvtDT7lYg9yDKfTda3pxShEN/MNBzXpLZbJ31sw/Q0+L0eNL8V/7/8PvE8plNSBgVL48
         FwWgSNw+MSk4cm1HAf4wwuyAzQjMM0muvn39wrCz4IhT0eB4kddg5dXpW70jqWTGH3sf
         xPsLc+LhsRXGex+6jcTblv2QRsoWAGAKlifVaRGg+GqsCUDY723iCQkMJ0WqzT+urrk9
         hHvChkRkP+Uw8rr9c0QWPkBtwf59OTtsKR9wp3ndHJ0fgw6MnP6ZIge/fOLKWqbr/rOu
         J3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727001; x=1704331801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYb21apCi1TYD3rMtdP8WfHi0WzC/HMdru5c9HRlZNs=;
        b=MKnV3CSvDkkQH1A3zW/6/mMv37qp4GSdfoq4dNkTfshrRXHw7Wk286DPh6oqiECQaT
         R3HzO221pqokXF+Vls8BE8A8/gzVHkfuJ0KOsO0ACjtsdiN9R2TBSo2igGM0+dwYUQWI
         v0jIAYWUC9SlTOPcFe2AsG67/1Va/Y4uyQrUJHXe+ndUwpQbrQA32cmH/rK83wSltqYT
         mkOQbDC7tA458+m+PNzYxf0JhPzD8dkGKro6TYBsCiAXFdSWU4OBMpCVhRcvNOjLRbe0
         W7XuHx42txabaS3AQlyW6syXsCWw0jOPZ7XGrybIzK3drPT4cj7RHXKIv97j8fehpT21
         S8lw==
X-Gm-Message-State: AOJu0YyBVyC9uk8FcIyl18M3g6f3IZqO/3rdtvvXBYo5Vd2F/2C2sMoy
	EbVou4bMt36hGE2/TBo92Tg=
X-Google-Smtp-Source: AGHT+IFbwB5dYoCPShoUyN3gGBDHW/MhdQB64NzIhSh+zHEfXxD0LEkN8r+nG2buvhbqQoqF+96dtg==
X-Received: by 2002:a62:a50b:0:b0:6d9:d5a7:9ca9 with SMTP id v11-20020a62a50b000000b006d9d5a79ca9mr3972819pfm.0.1703727001425;
        Wed, 27 Dec 2023 17:30:01 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id x31-20020a056a00189f00b006d96bb5db5esm6393059pfh.96.2023.12.27.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:30:01 -0800 (PST)
Date: Thu, 28 Dec 2023 09:29:55 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: avoid debugging output for (de)compressed data
Message-ID: <20231228092955.00000520.zbestahu@gmail.com>
In-Reply-To: <20231227151903.2900413-1-hsiangkao@linux.alibaba.com>
References: <000000000000321c24060d7cfa1c@google.com>
	<20231227151903.2900413-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 27 Dec 2023 23:19:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Syzbot reported a KMSAN warning,
> erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
> =====================================================
> BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
>   ..
>   print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
>   z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
>   z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
>   z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
>   z_erofs_runqueue+0x36cd/0x3830
>   z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
> 
> The root cause is that the printed decompressed buffer may be filled
> incompletely due to decompression failure.  Since they were once only
> used for debugging, get rid of them now.
> 
> Reported-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/000000000000321c24060d7cfa1c@google.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
