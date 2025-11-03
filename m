Return-Path: <linux-erofs+bounces-1346-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D27C2E5E5
	for <lists+linux-erofs@lfdr.de>; Tue, 04 Nov 2025 00:04:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0nGw5B4Nz2yrq;
	Tue,  4 Nov 2025 10:04:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762211096;
	cv=none; b=EzDbzB0EljK96NJBcE4gKTwvdTAfEM8azdgHmTyFV+WTzYUY9KjsPYcmCH0yICpTavKxyGBOsM9ROV0n799zdmKIVyCv/unIb/981qU0XHJ/lUPGexwqufGldJp4D6L5dbQQcpuGO9nBQgzXXVv98Du8v6xfB3ASVrlIQOYLQRTRajV3PIXfbsTL2IqCTyQSgrE0g1Rma0i0FUXae+PvdpaFrFouDxbbpoCQ1YZALjzbVdq0GWLVVrDjjUaYkl8DzkXZmE89Sm1ddEJvnk8NZSOxBdmeVEK9TBbgbOYNpSQu6NLywl6LnfGLwcOUm5ilXA24RjDQO5Z7UAsVFWp22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762211096; c=relaxed/relaxed;
	bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWW0c+HPGx+o30V36s5szelxOiLw31qwh1BQtxyAzWWyZQdDxGR6xlHPqdOJA8X23UERmExe0Ul9cZmvEQ+6+dWP3uUj/RK2M4r/h9g9fZCEX/yed+/6nbD/nRrtOIvuIRF6Nei6ypPg6lzFMI5zJFz/Z1t6o6M5b3PV16hKhuE4dTxzETNk04AesDN1pnDzrVT7MRilUTTVmZu1KSMV7xZbfrjgsB6+JwjvEJUVoSnMbO/x1ODrvPfIZvMmQnnfIOhvnCmnyMN+UMTibz7NbWnmh+NMf8GgZr+udbSXhrqSIRHcRCazMdG/HqEt/hxMjv2vrZRnUeMXOmsKaKaFAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VFl8/Sbp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VFl8/Sbp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0nGv0F2Yz2ypW
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 10:04:54 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so166808a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Nov 2025 15:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211085; x=1762815885; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=VFl8/SbpH6wOnNb8rhksRo64Ki45FAiToG+g3FbncrRGBte6j5ethNIcmONmsBKm7Q
         csH3kMSW4hOEtNkItAUWBYw7yzS3OQK9oh4TgyFpSpwH337RjF5rIGrteZx0lPOfKC9r
         hpp1wKTmJS2mBKvcB8ETBK4HJZLTPuNpbKamI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211085; x=1762815885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=Aw2Bkv+X4MdfNQAWo3owG5sLVCBDoq656m8aDk07vCPOPRAUIig/U4OOG0UAltTZLW
         mKhoBPWPJlk6XMEAOiJqQEofx8Tf5MZCiW23GUdI1mFsPytwYwZYqfvzjKCT5AtSsbGe
         Xw40qAJXBFFsa+WNIzOQLVrq8fGhiRsSHxpKHFabeVXyMkGQq93CzYZcVVKSGCTCsG/E
         hULsA++3hwaYDm32XU061FMzsZmzghJg6sDE4PzrIg6M98ZFZtofIlcOb51U/IZc9ISz
         6F33HDQZvTlZJVki+xr4VR6RWBJ8RMCflwS+pAWC0/QmxfbWYukQnPZPe1lk1x8wpSGJ
         QLVA==
X-Forwarded-Encrypted: i=1; AJvYcCWgrAaR2CCfhcVqNl2Xk3ARhQzJsvqf1dkE42jvm04r3WQPhKepf+fMIQY8RXRFRJEGr5IU41o4z3MnVA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDanJ0kSByEnEDy3DUkg4yGQ6MYMhNovGX/nYbdynjT6yP+SiU
	K0T7R4LsWNyHw8M5sCLXhJ+G2ewpm7Yc13pNwtRyNglPK6qfVc5elHsAJytqgyp7nN/OpxmZh2S
	anaY5tA/s0Q==
X-Gm-Gg: ASbGncvdMeOOJFpzILTjM+uaLm9aNIaJ0q23NEEDlt2mC2Whqn4UZt9KXA9RB2y2Y8i
	5bBmGBc+dYNrQn4KpOArVn/2LAF/7TbKV+I+BWWaxEqTEGxXhOP8MXW23Xk5kLnudoA8KmnbPKZ
	f8WBszatGu2UNmo+Zf7YpGX+DkVy3CrAUfd/OXPgOyI80fgS5Jz7r+H/mL5NWtsJXxdbqsTthvg
	EKQHJw55herclPbKbYcTKJ3cnGeMGGaapVtOZAB8Hv9SI8NxUTjNfkv8FgysLLF9R11fk8QVe6q
	NclNiCF83YkjNQbrXfGhM5xWDeEWUq5F8rKiIm1cY+88e362hBseKl6nOXUkDNINkjJs78wBOu+
	KxBsmR2CtPfWuyruUruqP2OqwafYY1YHXPSbZ75E4GDYVJAtRSKEC41abk5v+1whprIrAZVtagB
	wTiMJRVHT/+Zm8y59cNqeFSKQ8ImZInBlCQX9TXx+GKNuYhTloZxfnoSV1C9gM
X-Google-Smtp-Source: AGHT+IHHM2T7fsD5foSJlXsI/2MLrJ9CFOZ3Y9YBTUibmG6N/XqvKMP98Lny+iizHsbJ1n7K6Y/Nrw==
X-Received: by 2002:a05:6402:2710:b0:640:b497:bf77 with SMTP id 4fb4d7f45d1cf-640b497c2a2mr6407613a12.35.1762211085320;
        Mon, 03 Nov 2025 15:04:45 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680578esm553755a12.10.2025.11.03.15.04.44
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:44 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso798271366b.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX92h40u9DXdMDPcFYyglYE3Wz9QI8mPvwJ73td2+wr+sNBwbMIG51Dnb/wQJ/mjoextYGAtkYNNrrkqw==@lists.ozlabs.org
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
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
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus

