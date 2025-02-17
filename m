Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10DA3854F
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 15:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739800978;
	bh=Y/ACctAo6QrRk56drrPi/lkaFBSlLzNAZgOt/c90Da0=;
	h=Subject:To:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JcAbbSvmd28wiUE2nEHy4N0EB73j5mWflN5oX1dAKwJepqfWyA/9PJLXQG7goPpss
	 TnBB1jm55gvDGrXwLdqGVpwj8CCmggk8/iyrNZBXlohppuOORc8cbvFquLrDTp5Q09
	 RuzBOjBKBrDQaUCFfO/4iRcQYOtVe6yuRwsXhYM33i7Jya3Z8utZI14DNH2mdaNL4T
	 mDZqLa+oH0JieorTGR+8cUUsqvu3Unai1D8U+Wok8wZWJzLCmIH3Oo0M7ijNYuZjXp
	 QBMAq10YUqYaNZwL9qUnIbHdKUpHWHZRByA7AzSePLI7UjOKpKUgG4MNavyN06wv9w
	 iXtPJ8YvzbPZg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxPW655K6z30Th
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 01:02:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739800977;
	cv=none; b=c+Tq4jJ62NgeWuHdhucVNVWDXQXHjnwm8ejN+fzRz7M41ejInAnDpgEV9wm8JudDVZBCLKHqBFhWNSRkF3dwbaXSRSfe9d2RH9Zgf0g1yu4LFP3U5yn+yHIXGW6rgMvVdh48M4ixt+hpGKmaOeNT88o4p4kOxLQAIW3Ef+FFDq1r8olkPa+thT+SKzBmyRKSoYUeyPL4bpJKEc9ixIs4stSeZTHEI6RsqueVX3N3/u8cmDwWvDoE41tbKZtDvBB0Jl854OaL4YnxowtwRwNzZfDGrgfjCwqZWbIKGxOSa1JtajAIdZmuEuXEeVx8KQQ44eH78YNvQAmnjZW9AwM4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739800977; c=relaxed/relaxed;
	bh=Y/ACctAo6QrRk56drrPi/lkaFBSlLzNAZgOt/c90Da0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGM7bRZ7OM37TRE6fNJKCKR+qT0xGHrvWyAjM6r3D7QcAggjPL+xwupXHwwXQOKNVcal0MjMBmAkwNn+Vq8uNop/2nunZ/TJG5gEEX++ggS0YELeEnXBu1EbQhhoL6sLKgglm6c7AL6y0w/La7sMikanqb61wZNHweAt8Y+vdg7lNquMwwrICCuXDtVz500BJJKpgxSlw6ISDQNBRqj6JvQ0zaks0xF8hNWqbAJ6FFbr0ci8WZ0X6c5H2Q3UZQAVtU0Fbixbj84y7MuLF7WjaTO1fXGRKOvLn+cgOf5BQnJiNtiZp8ysZ2jCb5UxCfsGoGcuRvvj5SaJ+2mi75BEJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i+8KtxM1; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i+8KtxM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxPW41BQbz2ynj
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 01:02:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6CF83A41389;
	Mon, 17 Feb 2025 14:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6FFC4CED1;
	Mon, 17 Feb 2025 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800973;
	bh=uEBz2GEGa4P8H8KEVKcK32TrATx7VSDS3297tavOP1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=i+8KtxM1BcgUeOXpAeh2W9EoO44msTrr+6OzkT83a/+lFYtnLHoQ6pjrHwknuZLl0
	 5ZRSIhmmzjUUhg6RIsCHuaRwPrTw3vnBiaP9XTQrBVeJa3jFv93w6yIElgKLroD6EN
	 PImhrP3P9LGvGJeP32xatXW15ztxZCj4E2eyj7BuuoGavU3szBem2FDmlspN5V0GqT
	 c31MCUGzZFv9O7eRpuqDMHkpfJ2x8rJlU3TFIFPTvpr4RW5dQkd80bMtiBVZA/AtoZ
	 ro/FRLTxUNj/JVQWdA2pTF43CeBJp6XAcbd3FAgp4YidJpiWEs5qA1nETzz0wuoLMn
	 05DzbvIbhAuwQ==
Message-ID: <9004c0071bcbe8df3dd2ccc1451bd8bb2eb6d79c.camel@kernel.org>
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: Yunsheng Lin <linyunsheng@huawei.com>, Yishai Hadas
 <yishaih@nvidia.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>,  Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Gao
 Xiang <xiang@kernel.org>, Chao Yu	 <chao@kernel.org>, Yue Hu
 <zbestahu@gmail.com>, Jeffle Xu	 <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Trond
 Myklebust	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever	 <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Date: Mon, 17 Feb 2025 09:02:48 -0500
In-Reply-To: <20250217123127.3674033-1-linyunsheng@huawei.com>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Jeff Layton via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, kvm@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>, linux-btrfs@vger.kernel.org, Luiz Capitulino <luizcap@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 2025-02-17 at 20:31 +0800, Yunsheng Lin wrote:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation.
>=20
> Remove the above checking also enable the caller to not
> zero the array before calling the page bulk allocating API,
> which has about 1~2 ns performance improvement for the test
> case of time_bench_page_pool03_slow() for page_pool in a
> x86 vm system, this reduces some performance impact of
> fixing the DMA API misuse problem in [2], performance
> improves from 87.886 ns to 86.429 ns.
>=20
> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawe=
i.com/
> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawe=
i.com/
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Luiz Capitulino <luizcap@redhat.com>
> CC: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/vfio/pci/virtio/migrate.c |  2 --
>  fs/btrfs/extent_io.c              |  8 +++++---
>  fs/erofs/zutil.c                  | 12 ++++++------
>  fs/xfs/xfs_buf.c                  |  9 +++++----
>  mm/page_alloc.c                   | 32 +++++--------------------------
>  net/core/page_pool.c              |  3 ---
>  net/sunrpc/svc_xprt.c             |  9 +++++----
>  7 files changed, 26 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/=
migrate.c
> index ba92bb4e9af9..9f003a237dec 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -91,8 +91,6 @@ static int virtiovf_add_migration_pages(struct virtiovf=
_data_buffer *buf,
>  		if (ret)
>  			goto err_append;
>  		buf->allocated_length +=3D filled * PAGE_SIZE;
> -		/* clean input for another bulk allocation */
> -		memset(page_list, 0, filled * sizeof(*page_list));
>  		to_fill =3D min_t(unsigned int, to_alloc,
>  				PAGE_SIZE / sizeof(*page_list));
>  	} while (to_alloc > 0);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b2fae67f8fa3..d0466d795cca 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -626,10 +626,12 @@ int btrfs_alloc_page_array(unsigned int nr_pages, s=
truct page **page_array,
>  	unsigned int allocated;
> =20
>  	for (allocated =3D 0; allocated < nr_pages;) {
> -		unsigned int last =3D allocated;
> +		unsigned int new_allocated;
> =20
> -		allocated =3D alloc_pages_bulk(gfp, nr_pages, page_array);
> -		if (unlikely(allocated =3D=3D last)) {
> +		new_allocated =3D alloc_pages_bulk(gfp, nr_pages - allocated,
> +						 page_array + allocated);
> +		allocated +=3D new_allocated;
> +		if (unlikely(!new_allocated)) {
>  			/* No progress, fail and do cleanup. */
>  			for (int i =3D 0; i < allocated; i++) {
>  				__free_page(page_array[i]);
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 55ff2ab5128e..1c50b5e27371 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -85,13 +85,13 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
> =20
>  		for (j =3D 0; j < gbuf->nrpages; ++j)
>  			tmp_pages[j] =3D gbuf->pages[j];
> -		do {
> -			last =3D j;
> -			j =3D alloc_pages_bulk(GFP_KERNEL, nrpages,
> -					     tmp_pages);
> -			if (last =3D=3D j)
> +
> +		for (last =3D j; last < nrpages; last +=3D j) {
> +			j =3D alloc_pages_bulk(GFP_KERNEL, nrpages - last,
> +					     tmp_pages + last);
> +			if (!j)
>  				goto out;
> -		} while (j !=3D nrpages);
> +		}
> =20
>  		ptr =3D vmap(tmp_pages, nrpages, VM_MAP, PAGE_KERNEL);
>  		if (!ptr)
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15bb790359f8..9e1ce0ab9c35 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last =3D filled;
> +		long	alloc;
> =20
> -		filled =3D alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc =3D alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> +					 bp->b_pages + refill);
> +		refill +=3D alloc;
>  		if (filled =3D=3D bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
> =20
> -		if (filled !=3D last)
> +		if (alloc)
>  			continue;
> =20
>  		if (flags & XBF_READ_AHEAD) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c..e0309532b6c4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4541,9 +4541,6 @@ static inline bool prepare_alloc_pages(gfp_t gfp_ma=
sk, unsigned int order,
>   * This is a batched version of the page allocator that attempts to
>   * allocate nr_pages quickly. Pages are added to the page_array.
>   *
> - * Note that only NULL elements are populated with pages and nr_pages
> - * is the maximum number of pages that will be stored in the array.
> - *
>   * Returns the number of pages in the array.
>   */
>  unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> @@ -4559,29 +4556,18 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, =
int preferred_nid,
>  	struct alloc_context ac;
>  	gfp_t alloc_gfp;
>  	unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
> -	int nr_populated =3D 0, nr_account =3D 0;
> -
> -	/*
> -	 * Skip populated array elements to determine if any pages need
> -	 * to be allocated before disabling IRQs.
> -	 */
> -	while (nr_populated < nr_pages && page_array[nr_populated])
> -		nr_populated++;
> +	int nr_populated =3D 0;
> =20
>  	/* No pages requested? */
>  	if (unlikely(nr_pages <=3D 0))
>  		goto out;
> =20
> -	/* Already populated array? */
> -	if (unlikely(nr_pages - nr_populated =3D=3D 0))
> -		goto out;
> -
>  	/* Bulk allocator does not support memcg accounting. */
>  	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT))
>  		goto failed;
> =20
>  	/* Use the single page allocator for one page. */
> -	if (nr_pages - nr_populated =3D=3D 1)
> +	if (nr_pages =3D=3D 1)
>  		goto failed;
> =20
>  #ifdef CONFIG_PAGE_OWNER
> @@ -4653,24 +4639,16 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, =
int preferred_nid,
>  	/* Attempt the batch allocation */
>  	pcp_list =3D &pcp->lists[order_to_pindex(ac.migratetype, 0)];
>  	while (nr_populated < nr_pages) {
> -
> -		/* Skip existing pages */
> -		if (page_array[nr_populated]) {
> -			nr_populated++;
> -			continue;
> -		}
> -
>  		page =3D __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
>  								pcp, pcp_list);
>  		if (unlikely(!page)) {
>  			/* Try and allocate at least one page */
> -			if (!nr_account) {
> +			if (!nr_populated) {
>  				pcp_spin_unlock(pcp);
>  				goto failed_irq;
>  			}
>  			break;
>  		}
> -		nr_account++;
> =20
>  		prep_new_page(page, 0, gfp, 0);
>  		set_page_refcounted(page);
> @@ -4680,8 +4658,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>  	pcp_spin_unlock(pcp);
>  	pcp_trylock_finish(UP_flags);
> =20
> -	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
> -	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
> +	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_populated);
> +	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_populated=
);
> =20
>  out:
>  	return nr_populated;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f5e908c9e7ad..ae9e8c78e4bb 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -536,9 +536,6 @@ static noinline netmem_ref __page_pool_alloc_pages_sl=
ow(struct page_pool *pool,
>  	if (unlikely(pool->alloc.count > 0))
>  		return pool->alloc.cache[--pool->alloc.count];
> =20
> -	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk */
> -	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
> -
>  	nr_pages =3D alloc_pages_bulk_node(gfp, pool->p.nid, bulk,
>  					 (struct page **)pool->alloc.cache);
>  	if (unlikely(!nr_pages))
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ae25405d8bd2..6321a4d2f2be 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -663,9 +663,10 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  		pages =3D RPCSVC_MAXPAGES;
>  	}
> =20
> -	for (filled =3D 0; filled < pages; filled =3D ret) {
> -		ret =3D alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
> -		if (ret > filled)
> +	for (filled =3D 0; filled < pages; filled +=3D ret) {
> +		ret =3D alloc_pages_bulk(GFP_KERNEL, pages - filled,
> +				       rqstp->rq_pages + filled);
> +		if (ret)
>  			/* Made progress, don't sleep yet */
>  			continue;
> =20
> @@ -674,7 +675,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  			set_current_state(TASK_RUNNING);
>  			return false;
>  		}
> -		trace_svc_alloc_arg_err(pages, ret);
> +		trace_svc_alloc_arg_err(pages, filled);
>  		memalloc_retry_wait(GFP_KERNEL);
>  	}
>  	rqstp->rq_page_end =3D &rqstp->rq_pages[pages];

I agree that the API is cumbersome and weird as it is today. For the
sunrpc parts:

Acked-by: Jeff Layton <jlayton@kernel.org>
