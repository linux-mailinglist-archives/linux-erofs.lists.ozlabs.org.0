Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 276768CF2CD
	for <lists+linux-erofs@lfdr.de>; Sun, 26 May 2024 10:16:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L0Cco1rI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VnBG44kLBz3frb
	for <lists+linux-erofs@lfdr.de>; Sun, 26 May 2024 18:07:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L0Cco1rI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=net147@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VnBFt6nP2z3dLj
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 May 2024 18:07:13 +1000 (AEST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2e95afec7e6so17709491fa.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 26 May 2024 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716710822; x=1717315622; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aUSq5ALakaO4c9sqkL7smNAa5A9xC1W3iGhprz+8+Bo=;
        b=L0Cco1rIr7L7l1rvsbZIUrn2Y916FtOxzvq9ZdhVonglOlJq1tbeP/aQzH5T0SH+zP
         qOIWyEn6/TqcUgnux/97E44HwkXVUtMbZ9e91+5+Yh7l8FvAf5CT93yMI6P8eXMqkbh8
         +1ASz/SV5lpv2COzVTLyN1wSUldRngdNPxt3PSw2XBdU2/reMYsztAzcRMKoEaK79xV9
         rb50cEIRoFEpaju3BUzUkaBaLODMFwUfE1joEHLVIp1wy4SQ8oJS7J1ciuLBwFp0aaZd
         bBYkHluN/JcYITa0KmIA81/cjSFmRY8vmaF7z6ISZdnq5t6KbstXaGQ0JT6gT61gK2/b
         EiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716710822; x=1717315622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUSq5ALakaO4c9sqkL7smNAa5A9xC1W3iGhprz+8+Bo=;
        b=iLN78Or15Y14s0PYWqEOGWG8aF9RpYU/agtms1RJ6D+Ge9ST2EL5Yr1fQLhJuWWWh7
         Zq7Gd25zpqEfGSMcTccN4ggPM/i4V+QGLw7IU6A2To4b9VwrfE6vLyrSgArSQsTSQc/d
         WZ3b4RtwACMabJrzsRO/wC0MYSzcOvnfn8YJ3g7lV0ewWDqFJ+YTpgBAo7LKc5oSCvBk
         J3oN7D7maCFeP7CP++WeYt2qFQjU/4/5rYVuAB0yQ9sefHmgdkcTNa9/GzsgA1788uAU
         d/ZfC4tyL0KwM6x4MLuohQBuZjlTvZ9gONd5DrGwbcoWwmj5RIN8t+Rw3wZz4gmx9MI4
         Qorg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4TImybN6wNXeoKHQKnPRkbu8x6NIUTjuC/fSoATWRC5kNo1yICUP0C81bv8xG2QTAzlhQuFfrrCLxUnMnY6//3G/zImweBo42K2w
X-Gm-Message-State: AOJu0YwQl21lMIlkP3SME0sDD8D1wMQpj3O2dbwAqHv+Kq5IDIri1bXZ
	xAKs2iFB4LhGJqqiNPm+ydgdoZqRAV8IY/dyy8efnxlH9gJQlDN9taW6hIP29DGO6vEykF4UEHV
	Hea805+K0hoH23FsCa0TP7GPHpH8=
X-Google-Smtp-Source: AGHT+IG2V+QL4/tzCl/WAtC0qXh6YXnmUcMoehY7XlKCHrNrys6keozZ2Md84vnNq1FboyrkncWDcfvBB31w0ddcgoM=
X-Received: by 2002:a05:6512:48d2:b0:522:2990:7134 with SMTP id
 2adb3069b0e04-527f14d560emr2601409e87.33.1716710821531; Sun, 26 May 2024
 01:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220226070551.9833-1-jnhuang95@gmail.com> <20220226070551.9833-3-jnhuang95@gmail.com>
 <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com> <a9f890d4-555b-488f-85f8-8b22fdfd257b@linux.alibaba.com>
In-Reply-To: <a9f890d4-555b-488f-85f8-8b22fdfd257b@linux.alibaba.com>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 26 May 2024 18:06:50 +1000
Message-ID: <CANwerB1G8n57AfQ3CaH82CBPzQ8nvV=-Y5xRK6sVdnUZdj+SKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, trini@konsulko.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

On Sat, 25 May 2024 at 02:52, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi,
>
> On 2024/5/24 22:26, Jonathan Liu wrote:
> > Hi Jianan,
> >
> > On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com> wrote:
> >>
> >> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
> >> use the newest LZ4_decompress_safe_partial() which can now decode
> >> exactly the nb of bytes requested.
> >>
> >> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
> >
> > I noticed after this commit LZ4 decompression is slower.
> > ulz4fn function call takes 1.209670 seconds with this commit.
> > After reverting this commit, the ulz4fn function call takes 0.587032 seconds.
> >
> > I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
> > using -9 option for maximum compression) on RK3399.
> >
> > Any ideas why it is slower with this commit and how the performance
> > regression can be fixed?
>
> Just the quick glance, I think the issue may be due to memcpy/memmove
> since it seems the main difference between these two codebases
> (I'm not sure which LZ4 version the old codebase was based on) and
> the new version mainly relies on memcpy/memmove instead of its own
> versions.
>

> Would you mind to check the assembly how memcpy/memset is generated
> on your platform?

Here is the assembly (-mcpu=cortex-a72.cortex-a53 -march=armv8-a+crc+crypto):
000000000028220c <memset>:
#if !CONFIG_IS_ENABLED(TINY_MEMSET)
        unsigned long cl = 0;
        int i;

        /* do it one word at a time (32 bits or 64 bits) while possible */
        if ( ((ulong)s & (sizeof(*sl) - 1)) == 0) {
  28220c:       f2400803        ands    x3, x0, #0x7
  282210:       540002c1        b.ne    282268 <memset+0x5c>  // b.any
                for (i = 0; i < sizeof(*sl); i++) {
                        cl <<= 8;
                        cl |= c & 0xff;
  282214:       92401c26        and     x6, x1, #0xff
        unsigned long cl = 0;
  282218:       d2800004        mov     x4, #0x0                        // #0
  28221c:       52800105        mov     w5, #0x8                        // #8
                        cl |= c & 0xff;
  282220:       aa0420c4        orr     x4, x6, x4, lsl #8
                for (i = 0; i < sizeof(*sl); i++) {
  282224:       710004a5        subs    w5, w5, #0x1
  282228:       54ffffc1        b.ne    282220 <memset+0x14>  // b.any
                }
                while (count >= sizeof(*sl)) {
  28222c:       cb030045        sub     x5, x2, x3
  282230:       f1001cbf        cmp     x5, #0x7
  282234:       54000148        b.hi    28225c <memset+0x50>  // b.pmore
  282238:       d343fc43        lsr     x3, x2, #3
  28223c:       928000e4        mov     x4, #0xfffffffffffffff8         // #-8
  282240:       9b047c63        mul     x3, x3, x4
  282244:       8b030042        add     x2, x2, x3
  282248:       cb030003        sub     x3, x0, x3
        unsigned long *sl = (unsigned long *) s;
  28224c:       d2800004        mov     x4, #0x0                        // #0
                        count -= sizeof(*sl);
                }
        }
#endif  /* fill 8 bits at a time */
        s8 = (char *)sl;
        while (count--)
  282250:       eb04005f        cmp     x2, x4
  282254:       540000e1        b.ne    282270 <memset+0x64>  // b.any
                *s8++ = c;

        return s;
}
  282258:       d65f03c0        ret
                        *sl++ = cl;
  28225c:       f8236804        str     x4, [x0, x3]
                        count -= sizeof(*sl);
  282260:       91002063        add     x3, x3, #0x8
  282264:       17fffff2        b       28222c <memset+0x20>
        unsigned long *sl = (unsigned long *) s;
  282268:       aa0003e3        mov     x3, x0
  28226c:       17fffff8        b       28224c <memset+0x40>
                *s8++ = c;
  282270:       38246861        strb    w1, [x3, x4]
  282274:       91000484        add     x4, x4, #0x1
  282278:       17fffff6        b       282250 <memset+0x44>

000000000028227c <memcpy>:
__used void * memcpy(void *dest, const void *src, size_t count)
{
        unsigned long *dl = (unsigned long *)dest, *sl = (unsigned long *)src;
        char *d8, *s8;

        if (src == dest)
  28227c:       eb01001f        cmp     x0, x1
  282280:       54000100        b.eq    2822a0 <memcpy+0x24>  // b.none
                return dest;

        /* while all data is aligned (common case), copy a word at a time */
        if ( (((ulong)dest | (ulong)src) & (sizeof(*dl) - 1)) == 0) {
  282284:       aa010003        orr     x3, x0, x1
  282288:       f2400863        ands    x3, x3, #0x7
  28228c:       54000120        b.eq    2822b0 <memcpy+0x34>  // b.none
  282290:       aa0003e4        mov     x4, x0
  282294:       d2800003        mov     x3, #0x0                        // #0
                }
        }
        /* copy the reset one byte at a time */
        d8 = (char *)dl;
        s8 = (char *)sl;
        while (count--)
  282298:       eb03005f        cmp     x2, x3
  28229c:       540001e1        b.ne    2822d8 <memcpy+0x5c>  // b.any
                *d8++ = *s8++;

        return dest;
}
  2822a0:       d65f03c0        ret
                        *dl++ = *sl++;
  2822a4:       f8636824        ldr     x4, [x1, x3]
  2822a8:       f8236804        str     x4, [x0, x3]
                        count -= sizeof(*dl);
  2822ac:       91002063        add     x3, x3, #0x8
                while (count >= sizeof(*dl)) {
  2822b0:       cb030044        sub     x4, x2, x3
  2822b4:       f1001c9f        cmp     x4, #0x7
  2822b8:       54ffff68        b.hi    2822a4 <memcpy+0x28>  // b.pmore
  2822bc:       d343fc43        lsr     x3, x2, #3
  2822c0:       928000e4        mov     x4, #0xfffffffffffffff8         // #-8
  2822c4:       9b047c63        mul     x3, x3, x4
  2822c8:       8b030042        add     x2, x2, x3
  2822cc:       cb030004        sub     x4, x0, x3
  2822d0:       cb030021        sub     x1, x1, x3
  2822d4:       17fffff0        b       282294 <memcpy+0x18>
                *d8++ = *s8++;
  2822d8:       38636825        ldrb    w5, [x1, x3]
  2822dc:       38236885        strb    w5, [x4, x3]
  2822e0:       91000463        add     x3, x3, #0x1
  2822e4:       17ffffed        b       282298 <memcpy+0x1c>


I tried enabling CONFIG_USE_ARCH_MEMCPY=y, CONFIG_USE_ARCH_MEMSET=y in
the .config (but leaving it disabled in SPL/TPL) and it results in
Synchronous Abort:
U-Boot SPL 2024.04 (Apr 02 2024 - 10:58:58 +0000)
Trying to boot from MMC1
NOTICE:  BL31: v1.3(release):8f40012ab
NOTICE:  BL31: Built : 14:20:53, Feb 16 2023
NOTICE:  BL31: Rockchip release version: v1.1
INFO:    GICv3 with legacy support detected. ARM GICV3 driver initialized in EL3
INFO:    Using opteed sec cpu_context!
INFO:    boot cpu mask: 0
INFO:    plat_rockchip_pmu_init(1203): pd status 3e
INFO:    BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without
OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:   Error initializing runtime service opteed_fast
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x200000
INFO:    SPSR = 0x3c9
"Synchronous Abort" handler, esr 0x96000021, far 0x2957e1
elr: 000000000020233c lr : 000000000026a388
x0 : 00000000002fbf38 x1 : 00000000002957e1
x2 : 0000000000000008 x3 : 0000000000000065
x4 : 00000000002957e9 x5 : 00000000002fbf40
x6 : 0000000000000065 x7 : 0000000000000003
x8 : 00000000002c7960 x9 : 000000000000ffd0
x10: 00000000002fbc5c x11: 00000000000132e8
x12: 00000000002fbce8 x13: 00000000002c7960
x14: 00000000002c7960 x15: 0000000000000000
x16: 0000000000000000 x17: 0000000000000000
x18: 00000000002fbe30 x19: 0000000000000007
x20: 00000000002957d8 x21: 0000000000000009
x22: 000000000029d189 x23: 0000000000000020
x24: 00000000002fbf38 x25: 00000000002957e7
x26: 00000000002957b2 x27: 0000000000007fff
x28: 0000000000000000 x29: 00000000002fbcc0

Code: a9001c06 a93f34ac d65f03c0 361800c2 (f9400026)
Resetting CPU ...

resetting ...

>
> Thanks,
> Gao Xiang

Regards,
Jonathan
