Return-Path: <linux-erofs+bounces-179-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1CA82F47
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 20:52:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXsWd2GX0z2yqc;
	Thu, 10 Apr 2025 04:52:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744224749;
	cv=none; b=nGoVVkMhLI5DbOu2uVT0zLL7Hi2ELwvUEC20vOFTmPyQE7z7uhjQ5BNPlK4n/qFYWw7IsaTwwvvAcXh305NWgpqQhpDb76z8I7cIAnUDZct0XdVS2o1kpBEjcwgu3hdM6oTOBHmfml+gSsy00yRRtqw5MPAZCuZfphOEMcb2y8ZhqbLN6EacrDpx5z1KpNnyZ1P0cN4rsrpn5rrEgKxZqwcbYqUWIoHvhxiEDMtlZttylTfbY8AccwixJ1yq3oF1L/XmlAMDwsKm4glP+0R0Bh/XwyN8WeYMzk1NjnPmt3UtufzmIQsT2CbN+9yd5BTzv/Ll/bhgIIXDoJy2Us1iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744224749; c=relaxed/relaxed;
	bh=xCVIdbEnISAVHM1v2E2J31fW79EefnXRviLqNVsb5SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRr0+IIgRUakDy4+6eeaq4T7a1IpblWXxJmGseT1dlb9yosPrjpM1zR9nwdlhKvHro/WxOl1sKeHZ3QH8PdXAOHHNg81atcq5PJ3jHYPwrEcq6M6XSl9lwi9S6zzm2yMeSo6LprAieUsiqR/XfL9wkYi6hHfn/Qn8Nm+f6IiggN4Yrs4Zlw40UvKRB8b3mawtQ5dGAUCmxG/4Il5CGsXtMASD6X9SK3NOGsDJqtcdOpCkY3cmBhQjb+aWEAE8iCZhZ//mKzPx5HpIW0iY5soygxqz7/Mf1vDft9tpfvolOyXl4j+BwX+iHc2q0+Pe3W0YO+nDyZxpj4quMdMADngrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jd2Gx5jF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Jd2Gx5jF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXsWc1HRbz2yfM
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 04:52:27 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5967927f8f.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 09 Apr 2025 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744224744; x=1744829544; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCVIdbEnISAVHM1v2E2J31fW79EefnXRviLqNVsb5SI=;
        b=Jd2Gx5jFClI8/89E5ejrcYz7EoQxSQQ7MCkIJWbdC7IkI8m+ujeqa3Qt10O6q8Ngha
         pfEnWXciFY1sClmgiNNfvod8WEOsGt8fxACGkPgd7OGafzVV949mzMESJrHoFSsGY7Fs
         h1cOIX1/PUa1sJ6F+btuMfUuwoWHgukNOs/Sk/5QtLvwDNbV68OMpQ/PGXJiKVLeh24z
         Aw3ilso0uB0B6GYSyek4yk+5kzEq25XBIr7Fig0XX7UnzTc+1a8SDjecP5YFU1KYaBlK
         oib+xmgzzdbcRmtObKbdbJpmJQOHiWyXyfBsbW8TbyrU3O6EwhLqPg8+iQM7jsXNaH31
         DTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224744; x=1744829544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCVIdbEnISAVHM1v2E2J31fW79EefnXRviLqNVsb5SI=;
        b=cP7uQ5Xit4ltB+jVkhc3CYqxEPf9pQPL75Y7rlmzFyiRuV22hDn/TgDaWP5q474YL0
         bfCSm60MpYqMfM/rap+9ZGpDxAJ5VzQzdpob1u7uBixrrXCeG4pUlbM92oHaIRewEqKp
         7atOIRo6zWTWEWBhox/2+YmwILcvTjn8PsL+uXRzRJK2dGtpBQnpwljKmlsAUHQfB+ou
         C+YYHNX7d1mabWqaySkGAw+BxMzPzr1fm8XQvnxNQrCrwHCrKUgiBSRvsHht4xuFkaM/
         vOhyeh5PJq/SdbrYIJD/Dj6BjHeXOp2E+44Jxq/pMTZh49wCn65ctDfljZdhNxoEByE9
         Xw0g==
X-Gm-Message-State: AOJu0Yz5g4ad+U3bU/j7/R5FdCvZEdkbDuqw1Ybclu8ioqWEgJss35kh
	cffoH8v+iwAtI3vm9f8iJfpO9pojPbmSIfHg0wFz4X2MPY3PRCsD
X-Gm-Gg: ASbGncuQH0hYFcQhzLhsp40f9U61hORG7+y2COJCvKjLuctlAn4NahLXgImx+YenmSN
	UcJWaXAZzqkDGEo0DZppFo/pNm6YLMftOnUcIPmgLzhBNWuyyCR1wDAPLulSyPm6FqQJwgU+/WL
	y74jm3bbzf+JZwyqkBCU61DUHIkOdl7rn9mjfnw3intHzVFUEccas+rsiScUKEUOD7DGvhSgls5
	ZWmgT9sRqSwn8dzyDF9AQNc7zk84XtEq8rx+HWJkaoOSe/p6YYJGijJxzXHBsv3CDrYLRC19NTP
	kFYrHh1oU2ZXE05NdQFYZ/NGPr5cI9ttaB3wfmhi7dgE4RqAOff8JB2K6QRW7vLav1/YTzbuv/z
	jRK4=
X-Google-Smtp-Source: AGHT+IFzHMs8v+x+fqbf8EJaLOokSyNCKkLysUCzAg9iwIuL/fHNWqtDfjEXm8SBtK1JSxE2iUr9OA==
X-Received: by 2002:a5d:5c84:0:b0:391:2932:e67b with SMTP id ffacd0b85a97d-39d87ac017dmr4022308f8f.35.1744224743857;
        Wed, 09 Apr 2025 11:52:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0b90sm2391844f8f.79.2025.04.09.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:52:23 -0700 (PDT)
Date: Wed, 9 Apr 2025 19:52:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] erofs: add __packed annotation to union(__le16..)
Message-ID: <20250409195222.4cadc368@pumpkin>
In-Reply-To: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
References: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue,  8 Apr 2025 19:44:47 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> I'm unsure why they aren't 2 bytes in size only in arm-linux-gnueabi.

IIRC one of the arm ABI aligns structures on 32 bit boundaries.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202504051202.DS7QIknJ-lkp@intel.com
> Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
> Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 61a5ee11f187..94bf636776b0 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -56,7 +56,7 @@ struct erofs_super_block {
>  	union {
>  		__le16 rootnid_2b;	/* nid of root directory */
>  		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
> -	} rb;
> +	} __packed rb;
>  	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
>  	__le64 epoch;		/* base seconds used for compact inodes */
>  	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
> @@ -148,7 +148,7 @@ union erofs_inode_i_nb {
>  	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
>  	__le16 blocks_hi;	/* total blocks count MSB */
>  	__le16 startblk_hi;	/* starting block number MSB */
> -};
> +} __packed;

That shouldn't be necessary and will kill performance on some systems.
The 'packed' on the member should be enough to reduce the size.

I'd add a compile assert (of some form) on the size of the structure.

	David

>  
>  /* 32-byte reduced form of an ondisk inode */
>  struct erofs_inode_compact {
> @@ -369,9 +369,9 @@ struct z_erofs_map_header {
>  			 * bit 7   : pack the whole file into packed inode
>  			 */
>  			__u8	h_clusterbits;
> -		};
> +		} __packed;
>  		__le16 h_extents_hi;	/* extent count MSB */
> -	};
> +	} __packed;

Ditto

>  };
>  
>  enum {


