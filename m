Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C19E1E8B
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 15:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733234429;
	bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Hd0SJcSeYjnU0QAU2bHausFKmMg5Lx0qrDex3EDA3bAkCTgd2FCppXsmUOtIpNamd
	 jeyUy7Eep8bQE722QTj8n5oLxhky/2INFNsg6Up8LJ1sfOtYoznDHjlw+9jH+uQrDf
	 NXDjRY51UYnIMeE8Vmby5IEcGczFNwzQMkSqbfxcItZsSvwfQvXEYW2lSqwuq2lHQU
	 pK0eTJlXXtg3EewQJJ9iL1/ci9eIvPB+yl1C5m0kOtf3JggeyeQvM1PqRCLQ4qvSS3
	 Gbznno3STFty3Jl5VQEPsVNjhjZW9lZ1BP1Pew/39Wwl8ElxMpBWQkPKKbjJU1K/cU
	 8tvw1vGG6ZZsw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2j3K5FLSz30Pl
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Dec 2024 01:00:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733234428;
	cv=none; b=P64Z/MD5q4rsYWg1o8tHTYzYnnWeLLcn7tr5zf6XZjpUTNbSQuNN/0O/0pk6GhOX/795wHzJnSYm2w0J5U2nJj7ylyIpTvJE2mla9ewN3trTitZGv8qkgpDi1azqbCyzBB8mlm4JBmk8dIjoDjBAKaJVedVCKoiydUrasCfY4Dh3P7IkVAhyysPprJYQsHfF6GB0yWobOo3VnIVczsTFd1EzJe7H79kIa4Y6xprfHPI6DtNSrWp03OKsD29t3B/3MqmcfsSIStAX+oWx57ZC+Q3bKwcVVUPXaa/ZgUxAxAISwQFgqfA7bPmN8AtY24wGAJ6vhCyWPSKI5nGWBv6UHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733234428; c=relaxed/relaxed;
	bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KllXs7JU5OHTa8h2evH3fao9HOtfPPsijMHI/aGRAe/R1lcRi94/gqRLh9MASVE9kSA6YVgOH77MNhZIvChINhVzPeDUjjldhVn8brAvK7cwGFv2OiPj6z9md50BNivSWK9ijlx3NJofqAzcSdKkBemls5g9ZRmUmUeHkeCFy1L7dE596y8y/x/0HwqLtQkSpek8PxBvmbnfwNWFfHzbQJoBTBmLtMj+0455Oh0XeetoXFiBIaU8GGtRErgzq6lO7TNGr71rCuM4C4YRl5/8BI/a3pW1WOtxkjJtNB3OUccAUw1ll6tOgSYjBTC1sdMKkklmIgLTmtsAis0igYllOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Aj6Ki0jL; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org) smtp.mailfrom=ionos.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Aj6Ki0jL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=ionos.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=max.kellermann@ionos.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2j3G2Q0Lz2xQK
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Dec 2024 01:00:23 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4429707f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Dec 2024 06:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733234420; x=1733839220; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
        b=Aj6Ki0jLzel6ed5R7W84azDBZvoop9hEooc3x3vVe/C6C7g/CXZWlRnUuOMA75E8zk
         6gfHvgSnQNAQjDCbdH0/iiMOo+eY9A1jpKUr1b0c9liFC4HHj8B5mydyaRG4lzqA2Odu
         9ndHr4UuUP1++k3zR3ckDLy8tclzzHjLYZv3tvXcNeLo0s3jHKEqKhFQS+pvJxC4e9ch
         SmNsZhh1Q478BM8DcdozpI84GSeLtzWveLMOigekZiocB4G1+oU8h80wN6WG8YIxo3CA
         OXonC5iQEP2Wb2SVLv12Nc7mZWNwNmLDp0OmP6/ffYuh0UAAFdLPw2WLe+wxwVZyKEMv
         6b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234420; x=1733839220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ogWsoKVLGEepBB9n0gfB3e54+++vjJBGpvcY0eB2A=;
        b=XAVrrfaOyGphmKAuazhICFSa5ezgeZmxVVZz4bDGAYVP35IO0AU3gRctdp3WK9auAc
         9KPaNQmNSuNSwtjK4EPYErkvjUkyu+UJxeuif+hpoLHuH0s2pcAagQTMifVPf8hWw+F1
         lmSL7lzTBC0yONW7kLQ29PdHhGo6KqAw3DRXzaKYYMuC9WkuWGgYYbEK4/Cjv0b/Ltbd
         nMUlaWGojqAcO3/A87yPEZ/L/mIitTLRBnP0o/edzFcFzJH/wRrfZR0uKDNCTwMPsMiI
         WjRKmiMFEPKjv/oFUdL1sUYf3cVwwNgxCbAPh42Z2zCpkwYORHEgeDvc/WahtyO5w4fr
         JOxg==
X-Gm-Message-State: AOJu0YxZs3yoyqc5u6YJyv6OJyGPEcxM3L3v5RAS8CkQ9hics/S3i6qN
	gj8/pXj/IcRmxfMDSi3Y+mxnFvSzRvKIeE3qPC7HWhbcoqCKpFDcslRsRTN7vmjN2iH+t4CWfNi
	uzTIQ03MIzoiDXe5s1OauM5MYhdya8+0ehPSFXw==
X-Gm-Gg: ASbGnctaAJdBEz63FVIH7DBRhv6josjEZgWShlPGJpQO2ZjzxoD3H2igyhGfCQLaeUz
	ZVAp09faB5osc9f7LrHEKETe3V+D4QGxxOdsbNrH4UF8Jlyqdp8hVhA71wy69
X-Google-Smtp-Source: AGHT+IHGs1wkYOjPfG6IkJlIa5Him6GjcmHqHXOYUHi3/uFgyDlfRxVXnTdrbUJka9yWUdOJC6wCZGhcBGYTlLj3iUo=
X-Received: by 2002:a5d:5f8b:0:b0:385:ef2f:9278 with SMTP id
 ffacd0b85a97d-385fd3cd993mr2977493f8f.2.1733234419785; Tue, 03 Dec 2024
 06:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com> <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
In-Reply-To: <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
Date: Tue, 3 Dec 2024 15:00:08 +0100
Message-ID: <CAKPOu+_ZGtCX48bntZQU=nGxqFPon+D_wDPiagtZPKmtYRfpgQ@mail.gmail.com>
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

On Tue, Dec 3, 2024 at 2:30=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> __builtin_return_address(1) instantly crashes the kernel

I was able to capture the __builtin_return_address crash on a serial
console (this has nothing to do with the PSI memstall bug):

[16438.331677] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[16438.338693] #PF: supervisor read access in kernel mode
[16438.343866] #PF: error_code(0x0000) - not-present page
[16438.349038] PGD 0 P4D 0
[16438.351588] Oops: Oops: 0000 [#1] SMP PTI
[16438.355625] CPU: 18 UID: 2147486501 PID: 23486 Comm: less Not
tainted 6.11.10-cm4all4-hp+ #291
[16438.364297] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
Gen10, BIOS U30 09/05/2019
[16438.372880] RIP: 0010:psi_memstall_enter+0x7f/0xa0
[16438.377708] Code: 89 df 80 8b 19 05 00 00 01 48 8b 45 08 48 89 83
c0 08 00 00 48 8b 45 00 48 8b 40 08 48 89 83 c8 08 00 00 48 8b 45 00
48 8b 00 <48> 8b 40 08 48 89 83 d0 08 00 00 e8 d1 fe ff ff 4c 89 e7 e8
29 28
[16438.396609] RSP: 0000:ffff9ee683bc7bd0 EFLAGS: 00010002
[16438.401869] RAX: 0000000000000000 RBX: ffff90c70c291740 RCX: 00000000000=
00001
[16438.409052] RDX: 000000000000000a RSI: 0000000000000000 RDI: ffff90c70c2=
91740
[16438.416234] RBP: ffff9ee683bc7be0 R08: 000000000007cec1 R09: 00000000000=
00007
[16438.423418] R10: ffff90c727d83678 R11: 0000000000000000 R12: ffff9124bd0=
ae000
[16438.430600] R13: 0000000000000014 R14: ffff9ee683bc7ce8 R15: 00000000000=
00000
[16438.437785] FS:  00007ff15f1f4740(0000) GS:ffff9124bd080000(0000)
knlGS:0000000000000000
[16438.445929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16438.451714] CR2: 0000000000000008 CR3: 000000010c54a002 CR4: 00000000007=
706f0
[16438.458896] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[16438.466079] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[16438.473263] PKRU: 55555554
[16438.475984] Call Trace:
[16438.478446]  <TASK>
[16438.480557]  ? __die+0x1f/0x60
[16438.483636]  ? page_fault_oops+0x15c/0x450
[16438.487761]  ? exc_page_fault+0x5e/0x100
[16438.491710]  ? asm_exc_page_fault+0x22/0x30
[16438.495923]  ? psi_memstall_enter+0x7f/0xa0
[16438.500135]  read_pages+0x205/0x220
[16438.503647]  ? free_unref_page+0x2c1/0x420
[16438.507771]  page_cache_ra_order+0x1d3/0x2b0
[16438.512069]  filemap_fault+0x548/0xba0
[16438.515845]  __do_fault+0x32/0x90
[16438.519182]  do_fault+0x2a1/0x4a0
[16438.522519]  __handle_mm_fault+0x337/0x1ca0
[16438.526730]  handle_mm_fault+0x128/0x260
[16438.530677]  do_user_addr_fault+0x1d8/0x5b0
[16438.534889]  exc_page_fault+0x5e/0x100
[16438.538663]  asm_exc_page_fault+0x22/0x30
[16438.542697] RIP: 0033:0x55ebb60829a0
[16438.546298] Code: Unable to access opcode bytes at 0x55ebb6082976.
[16438.552519] RSP: 002b:00007fffd2a03658 EFLAGS: 00010246
[16438.557779] RAX: 0000000000000016 RBX: 000055ebdb88b410 RCX: 000055ebdb8=
8b410
[16438.564963] RDX: 0000000000000ee4 RSI: 000055ec5b0b1e30 RDI: 000055ebdb8=
8b910
[16438.572147] RBP: 0000000000000010 R08: 00000000ffffffff R09: 00000000000=
00000
[16438.579331] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00046
[16438.586514] R13: 000055ebb6099e6c R14: 000055ebb6099c93 R15: 00007fffd2a=
03706
[16438.593697]  </TASK>
[16438.595895] Modules linked in:
[16438.598970] CR2: 0000000000000008
[16438.602307] ---[ end trace 0000000000000000 ]---
