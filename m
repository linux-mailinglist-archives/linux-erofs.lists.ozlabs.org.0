Return-Path: <linux-erofs+bounces-3458-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HOUJWTBDGqJlgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3458-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:36 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F77584670
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 22:00:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlsF2FgFz2yCM;
	Wed, 20 May 2026 06:00:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779220833;
	cv=pass; b=dDUpaeANnXKOcc0Vrl/S0m37W7imi9CrGa5MtWZ4FPoC374YaaaLoHK0Ow3vIGCRw+PJkmk95GlHXZK2QSumfLtREi1ErrzA7heK5krHcmDXv7gK8p07iSMUzi7qzo0sUXBft7K63eUPKgo9QAZAT4v92bww3JqUh6q3frZ1STT44BsW2YFQcq2KJAfSnVHVJxDNVQ5CxdvSTYsGpdX/XhufReTqpohkSr0G7qjg+BoSgjlcKmg9Gck22VnvXZfgtR7t+A/ikWPk7a40YQSZix8U/t9rDC3q7xBkjmI7plaNigCy6TurGAZysJM5q4xC+GN3Y6bTU5cK1o+NI7CsMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779220833; c=relaxed/relaxed;
	bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqDurSGBATt/LYqO1v9T4kOTyxpBxLVZkdXbsBCFhKu/8VimlVCCuFl4Bu4vJm2aDUwDXTwWkFPG0WAYPUrOb5kJ+Dq1dHgeOxtjrF3O0AYOWhbFUPNN5NoaZ36XCvqPz7P1OFBTfB2T8gQlFiuAlbrcaTr62KtWSW5Dminb93nBwe11qxkVSfVE2c7ijMfAo4LdVEL+1nZEIaU1JAONgB0G/n7pGE2fLCc5gMIu/f7qdpz/Ro0kgH6TD81vlWfdG3jJQX3UvM+V+Hr9I/B8TDcbWPgdFWwlui6FFwV0PbCKm+CMDcSVVnA/TXIjLS+gjSOWwys6SPMOy/6xpMzcOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OQ3t/E4I; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OQ3t/E4I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=sjg@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlsD2z95z2xwH
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 06:00:32 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso823687666b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 13:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220829; cv=none;
        d=google.com; s=arc-20240605;
        b=O99iP/IFS80BfpQT8/PmOHVEI0q+ZaqujrB7aRvkKB5GzlKsz7UWjSGaDxQbfm9Xk0
         ytyXW/2q7iodDQIV1vilCFa2cAdHYn9DkUkRp3xOQEQ/htSHnInNq/qXGf0kn6/xkGAF
         v4gs8+t9hizzsf32zy8mwiV5nNn19E5m8niT8FEBDMgndDEEm/+weQA4+xieFgCZ8kg4
         i1NzjH7I1KIJ+goXQgnX4JO4PWLQvtS9OADQYpIVuF+rn5KKDwOxO/7gU4uJo5szcxK4
         w35e4YA4kyjwsPtvauOrRRD6y9roLindMB/IWKlU8mPet0ZuAl1LdnxcA0gKl7sjCzIX
         eBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
        fh=CcJoK1MOjzoL5tfTcf8T8K5AzonTsP3KzfUBSTgfLfg=;
        b=GjNiBYbG+oc3zJgRg1khjr0/hlHUBlV4vdkYL0Ls59kpAnHV7Gb7M/uRtiwPCgrYDr
         fNaoxjtjz0OhZLJehd/Gyfuaon0XymX5D2X6IuyVPYHQRoYHalaDur4hfZzQBsDe2n+D
         qYzvqt/4TwVc1YoA5xvUXQgFZMkKADhxa4e62YEBunbSoYDeqiaKvQiY5bzI3f0Lck5J
         7TUB9kCxfEBpPryMzQoPbubGN1RUlZ+s9E0AB7sxmrue92PUSpzyFW98at1LZ6brZRcZ
         ictcFARXAerjcCoxa6lbEGBw8Zxozx18smM+O01JhRkk8z3nxKwPNOr30PaVRl2g5pTo
         xEew==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779220829; x=1779825629; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
        b=OQ3t/E4Irp88WXv7e3FU6UyZ8YU35Scp9AHv8SBMsLfpsCv6T6mHmiFdaWYCeWQvya
         4fp138QpUZaEgs3EVyqu+2ZwaQiDQf1cGjjsQisHdV65J4n0ZJeumvmY5DhS0ULwhQti
         7BfZFxLIImbJs+i3Jlt1lrWMXIi30Lb4zBUeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220829; x=1779825629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGqp4mYGEGYMrYwyBMbapHPlbpcMOMmsuGPblsGydZM=;
        b=SWYZEsEDQr04iq9jjGc+CtNYYWuTxDEwkodnqnacNVYlo46seR92PCynG3D4XI7cXd
         owR0l/7Cq+7g+44gRUIvsv8vyDRI6zg3tC+dwUb/+pgyCPzFosfXhH64IEQT4jYmpPYc
         8FCYcqgyA5CEdQCQyvBalglLfJ7Wp3RiPtq8F4qtxiW6K+zlXr6sSlIMA25Jma93nluV
         R8s2ZkARKmYmFqZJcN6yPypB6Lj1jLTQRMYFiG+ncJOyCHwYKdUICAB3iYTLfCFhC8s4
         sRchz8UQy/1pWqVopfovNvijGkZ7xYPGSO9GgDLZJ7IvHqYsUnmy4dkXl7rXbeypckBq
         illA==
X-Forwarded-Encrypted: i=1; AFNElJ/VDfHQIrouQH45mf2ISXVOJTjO1xaI6WLd280WJiC8SDXjM0m71EBXTzAp1rQFsQH+sGRVXvosrb9UGg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZzigs078WN4SE7/AxcvzPfxiXtUZpIu63rKDBIJnXwZqUelZy
	N4nSvqXUCkHDv5W5VezgyI6docJOMpPvzFYG/Zqz170GigUd0BjuzqNzdaGofHEYnbvNsKE+DkD
	8QfAauyLSNQki/j5tcwRiZzY3GnA8qJMG6ki7Tr5a
X-Gm-Gg: Acq92OHsadHk0VXhQ6/BBd3G6pSZYDl258EEpsGi/KMgKqe2hlFfbWddQU+Ic3rdhXt
	b037yNiIrIJ9MnyiNSKo6eBv4/Mi5uEnZqa33ObQIPhQYnM47FeSpv4HFoFDhqwmNU6k2FnmxWa
	WgM3uhDcBvsRgGQ5EroeqP0yPSDFoaUplEzAk5xnf15anE0QrCu53zMgXlF+opkiYJEWLxxg+xd
	7AkmRd9bD/y20BNvPO+9eoLtdwGmH8GvcNILmwMVq0q/qu5MGHeeQJf5ZOUu+sExdPw3qrPiUPo
	vscjKg==
X-Received: by 2002:a17:907:a68b:b0:bda:2928:ff9a with SMTP id
 a640c23a62f3a-bda292920a3mr112394966b.39.1779220829325; Tue, 19 May 2026
 13:00:29 -0700 (PDT)
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
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com> <20260518055728.178507-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:19 -0600
X-Gm-Features: AVHnY4IFIErVj3TEvq9UnA9JoyMbut4QP3G3ELTItm1k0rkzoCJf1CyfZqZ0EPM
Message-ID: <CAFLszTj2R-oT5jykouzGPcBfvJ+_Qp1YPqEbonk16uqAy9DDxg@mail.gmail.com>
Subject: Re: [PATCH 5/9] fs: ext4: set inode timestamps on write
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
	Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Tony Dinh <mibodhi@gmail.com>, =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
	Francois Berder <fberder@outlook.fr>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
	Daniel Palmer <daniel@thingy.jp>, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
	Sughosh Ganu <sughosh.ganu@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3458-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:heinrich.schuchardt@canonical.com,m:trini@konsulko.com,m:sjg@chromium.org,m:jnhuang95@gmail.com,m:quentin.schulz@cherry.de,m:mibodhi@gmail.com,m:t.preissl@proton.me,m:fberder@outlook.fr,m:andrew.goodbody@linaro.org,m:daniel@thingy.jp,m:varadarajan.narayanan@oss.qualcomm.com,m:sughosh.ganu@arm.com,m:ilias.apalodimas@linaro.org,m:peng.fan@nxp.com,m:marek.vasut+renesas@mailbox.org,m:u-boot@lists.denx.de,m:linux-erofs@lists.ozlabs.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sjg@chromium.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[konsulko.com,chromium.org,gmail.com,cherry.de,proton.me,outlook.fr,linaro.org,thingy.jp,oss.qualcomm.com,arm.com,nxp.com,mailbox.org,lists.denx.de,lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,canonical.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 79F77584670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: set inode timestamps on write
>
> Replace the hardcoded zero timestamp in ext4fs_write() with the actual
> current time obtained from the RTC when CONFIG_DM_RTC is enabled.
>
> Per the ext2/3/4 specification (ext2 design document, section 4.2):
>   i_mtime  last data modification time
>   i_ctime  last inode change time (the 'c' stands for 'change', not
>            'create'; this is not a creation timestamp)
>   i_atime  last access time
>
> All three fields are set to the same value since writing data modifies
> both the file content (mtime) and the inode metadata (ctime), and any
> write also constitutes an access (atime).  If no RTC is available, the
> timestamp falls back to 2000-01-01 00:00:00 UTC, matching the FAT
> write driver behaviour.
>
> The ext4 i_crtime field (true file creation time, added in ext4) is
> stored in the extra inode area beyond the base 128-byte inode and is
> not modelled by struct ext2_inode, so it cannot be set here.
> [...]
>
> fs/ext4/ext4_write.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -21,14 +21,47 @@
> +/**
> + * define EXT4_TIMESTAMP_Y2K - 2000-01-01 00:00:00 UTC as a POSIX timestamp
> + *
> + * Used as a fallback timestamp when no RTC is available.
> + */
> +#define EXT4_TIMESTAMP_Y2K   946684800

'define' is not a valid kernel-doc directive, is it? I suggest a plain
C comment.

Also, the natural sentinel for an unknown ext4 time is 0 (Unix epoch),
which the read path already displays as 1970-01-01; picking Y2K means
files written by U-Boot show 2000 while pre-existing zero-stamped
inodes show 1970, which is jarring. The FAT-parity argument is pretty
weak since FAT cannot represent dates before 1980.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -21,14 +21,47 @@
> +static time_t ext4_current_timestamp(void)
> +{
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct udevice *dev;
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (!dev)
> +                     goto fallback;
> +             if (dm_rtc_get(dev, &tm))
> +                     goto fallback;
> +             return rtc_mktime(&tm);
> +     }
> +fallback:
> +     return EXT4_TIMESTAMP_Y2K;
> +}

The label sitting outside the if-block and jumped to from inside reads
oddly. Please drop the gotos:

   if (CONFIG_IS_ENABLED(DM_RTC)) {
           struct udevice *dev;
           struct rtc_time tm;

           uclass_first_device(UCLASS_RTC, &dev);
           if (dev && !dm_rtc_get(dev, &tm))
                   return rtc_mktime(&tm);
   }
   return EXT4_TIMESTAMP_Y2K;

Also, this helper sits at the top of a 1000-line file but is only used
at the bottom from ext4fs_write() - please move it nearer to its
caller.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -979,7 +1012,11 @@ int ext4fs_write(const char *fname, const char *buffer,
>       }
>       if (existing_file_inode)
>               free(existing_file_inode);
> -     /* ToDo: Update correct time */
> +     /*
> +      * Note: ext4 i_crtime (true creation time) lives in the extended
> +      * inode area beyond the base 128-byte inode and is not modelled
> +      * by struct ext2_inode, so it cannot be set here.
> +      */
>       file_inode->mtime = cpu_to_le32(timestamp);

The comment describes a field this code does not touch, which is more
confusing than helpful. The i_mtime_extra/i_atime_extra/i_ctime_extra
fields (nanoseconds and the high bits past 2038) have the same
limitation and arguably matter more, since we are truncating the
timestamp to 32 bits via cpu_to_le32(). Drop the comment, or expand it
to mention all the unmodelled time fields.

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -854,7 +887,7 @@ int ext4fs_write(const char *fname, const char *buffer,
> -     time_t timestamp = 0;
> +     time_t timestamp = ext4_current_timestamp();

Note the parent directory's mtime/ctime should also change when a file
is created or replaced, but g_parent_inode is written back unchanged a
few lines further down. Not related to this patch, but worth a
follow-up.

Regards,
Simon

