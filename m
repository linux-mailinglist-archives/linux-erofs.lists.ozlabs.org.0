Return-Path: <linux-erofs+bounces-2899-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAhpNnE7vmlUKAMAu9opvQ
	(envelope-from <linux-erofs+bounces-2899-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:32:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F992E3AB5
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:32:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8jp2PPJz2yZN;
	Sat, 21 Mar 2026 17:32:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::434" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774074734;
	cv=pass; b=RgNf8UwDmSo1lT3BaBJhrOKCMyZRgvU5KjDGqEGJoFyrh5zNKo2iq8G75/AsBvH3P2S+LSQLRV3+7N0cOqciOH5oYKfUi4Rf070PgdvTfnDwaU79roLF9I2kWgvte2v2QHnAResvyu7lvpuElg4QZMKXSwuN0M12Q4n89kXX+6qyUOPAY/Mtat6tex+HzhRbUN8RGHFQT2dUmBCiJbmzST1Tat6axzYOBT51nfIiyCE+5JQhb3VKbO91IF5pw7D8fECViwKMBX8jFKQFuyNMY8OQPNgLI5tcoL59qnHCFxSRGYbgWlnQVzHM5J7Yp4f1xA6sVArP3jXyJAJlNF1JRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774074734; c=relaxed/relaxed;
	bh=yAK16XeDesrg9n4ebMLCi0eamvk0VRC4holpWQxjOBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6rU7MMPLXmfeX1HU6TZrtiO+gbEoqULdT5xbaZKiJm4l55G8vjjBodI0jrUlnJyMmwEPawfCkZymardUnwH7iVLFlhbwKTr3IrQmEZ+tiJ+x5lA07QpSyMnU7G0lYI/QiiKLJk/VLPohsuJZX1lmBMODvG3c3ckSCZod88H+C6y8Xa6vtpt6CE/19s3RyhSsElWUcbPWjERaMTY0CnZL5W0/crC7sE2772DHY/7Ya/hp9oS5vleuOMXOd+3vCoaynnEKxAq1m9MpyzynjDOsqoLaeZNRZ7siw97CEpU9gFTbtPAZyxW0Jqh7W3XUIA5P2y06nd4AScanIfuY6yiMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fPDojgln; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fPDojgln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8jn142Bz2yYq
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 17:32:12 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1944784f8f.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774074724; cv=none;
        d=google.com; s=arc-20240605;
        b=aUvrta4O0UYNL9F7B22pgee1wpf8sxF/eYouC4hz6NLLgQvgm9ZsjAcPujeYMvN2Tv
         tCSoVgk+KHYg/hI7lwQ9P7rpf7ymaYpYn11IfFTpTElfdSgnXddG/jUSxNVeYCTaXPQ0
         4am6yV1hPIr1uoq+aLmC1vD03PTh80tpkFbFPnXTCfapj5mIGMZ1zIoQ+dlE3TdO3trT
         5+TxynfzgqMwdOqIby2eFNpPNWz6p5Drgr8Z1Vo8qQ7GIEjsFtdWGaMVf5SrXsM8nSCA
         XygQQUBEkZZZ04t9reeUaT4IzZ25Bb4io8dCUDbNk78KttE97PVJuUpO3/J71DgTb15m
         i8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yAK16XeDesrg9n4ebMLCi0eamvk0VRC4holpWQxjOBI=;
        fh=dImzU/I8cAVUT6QAb13MEnLmVLjJaLsTYLGpjBlTJOY=;
        b=GqRzkNftQqV9VpPK6DLXQxboYXD4TgcbpIve/gsdf0w/STJmVU4A0MNDUEORvG3CV/
         /B60VD4WD13bPBkgjU0a+dFYvF3D5zbI+tN1qFZHBNeGm2uP6uqL0jpuo4UtiFmK7R/V
         t31cY18QD2A+dBrH8RDBNImtuHTnio77/HrEVvBb6Q9LsP2yKYDiExX8eVIm9AZUkpFZ
         FGQJjlDnU05sF6Wb+25LrI++YIw+lb0u+S1NVXgm27kKptlX+gL83u0OutQjcUuNecy7
         l8BxuSuOJFx9cYgB11I3M56AayZPvxqizztAedyk50LfYOp1squnYSrnNi8OJde5/DYI
         uDWQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774074724; x=1774679524; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAK16XeDesrg9n4ebMLCi0eamvk0VRC4holpWQxjOBI=;
        b=fPDojglnLsH8thSQkEMGjcw5pi7A+GL1YR1cOgbiE9aEL/yHi2B7+huNu+o1jrs2qF
         f3CYCrzMTCxSfBdGpkj0d27wQgGW7GhuCv1Lp1q0L9M4yYj2EWA6nuqSaTQe8g/Mi62B
         9rxkp2qPPx1kZ2K/L74IQN4tCTFhwa6Ou0vgeWdO0YMnkJH9RhLLpcM2xcRzKPtm9LCV
         uJNt6zbjDLKxm4LYOeLBDIU+trtZWiEWEBXJGDELJqEh5AyDjj6HkChcQl7QUnHFxUBv
         /rhrAFB0n1npExNdivkpvksraK1p6vE10fdvUvQWNrAXy/qRvLxkwZk1X4U3AddLeFjc
         oE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074724; x=1774679524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAK16XeDesrg9n4ebMLCi0eamvk0VRC4holpWQxjOBI=;
        b=MVcg2NVesJlcneTsTdIyPvUeOMIMzptrOSAXT3iiNe8irpD4FYsaeJcEr9UdMPN1Qr
         nFjA/osAzil5Vh2REwifg7/fTDGs5pCYL9WlWYuOtFEYIhsbSRARgNKPzaMhVxySNWkQ
         bv+iGbk+g47Zul8Q3/l+sPshH+14lX6YoSspKEbTTVkl6DrKXQlT+5hg/UUmcplElvZL
         zC6yjke02BSWxvcM69GugMG81Nd5ppDyvG0MIuXa1tqXe7Rv5yWFldL0Rfv8Rmqzr9FR
         pkDQURQY7O1o8CaxXh3cisXbIQFYApNPvFqtPHGvDpXptA1iNmIOZZMN6iuLUo/ISJzk
         ngcg==
X-Gm-Message-State: AOJu0YwQT9hd/USS+ne7ExzwfFWbvVBBR7YVtWvphrUjw/QcFFs4xrG4
	RDULVSPOBl0v663x4ari9WPqc6R74Hy/zJR4pQEQSaJk4at8M22mieJMLLZ4e7Dg8uW/1K/hFyo
	Qe1GiiQWTfcOHk1nJPyVPg/YYtRTJrx8=
X-Gm-Gg: ATEYQzwY2K+G1FGGPM3OnmwQxpzMKBXnWeW1WfKJZx6Iu8thh/JWkaq0Cf15z/o8qY6
	8lqtqQw/tiRThSI7WM0UElqgZbu3GtArIaRgsYqkH+K3VMmn/bqPI2Jrq4URuHzXzV9uICRNheQ
	7nXiBhDs/Ymarbx08gLgxVodQgMxTnYWEOK94ScKx5+ngWQPARfsu5V3bvwsZj7B0v5vKNW7lmk
	kVG9foRZmkDVqbf0Nbk8+GIEqAoPR+PdFPH7bu/jjwnjJaYriI31AGESgBXJ5MCRxVAnuq0bBg4
	2RKtGB8BbPgaQq3rNtdGXzIWcoCc5MUSZP+qU5g=
X-Received: by 2002:a5d:584c:0:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-43b642817a6mr8522488f8f.38.1774074723720; Fri, 20 Mar 2026
 23:32:03 -0700 (PDT)
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
References: <20260320165200.1862-1-newajay.11r@gmail.com> <20260321050725.60268-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260321050725.60268-1-nithurshen.dev@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sat, 21 Mar 2026 12:01:50 +0530
X-Gm-Features: AaiRm52__cddTMRWmaiPxq3-OGTmLNQ4kGV41Cv7EqqgoU9D2USKqbrMciRCDJk
Message-ID: <CAMhhD9iyzyY=ty0Ntf+j4oVW-oW5iZJ09EDdCdfEPHFXaf3LOQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Nithurshen <nithurshen.dev@gmail.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2899-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: F3F992E3AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,Thanks for the review
I have just sent out a v2 series that splits these into two separate patches.

Best regards,
 Ajay Rajera.

On Sat, 21 Mar 2026 at 10:37, Nithurshen <nithurshen.dev@gmail.com> wrote:
>
> Hi Xiang,
>
> Both the patches LGTM.
>
> I tested the missing return by truncating an image to force an I/O
> error, and the FUSE daemon now correctly aborts instead of hanging.
> I also dynamically tested the memory leak fix using Valgrind with a
> 10MB file and an injected Z_STREAM_ERROR, confirming 0 bytes lost.
>
> The only note is that this should be sent as 2 separate patches in
> the same thread.
>
> Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
> Tested-by: Nithurshen <nithurshen.dev@gmail.com>

