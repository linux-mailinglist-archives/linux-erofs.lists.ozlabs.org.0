Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73054D6DA
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jun 2022 03:18:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNkp96PVmz3bvW
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jun 2022 11:18:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=expoplatform.com header.i=@expoplatform.com header.a=rsa-sha256 header.s=mqy4nq24v44agy3wx43syyt7rieosr22 header.b=ZT8Kn/7s;
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=NMoDQ1DE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=eu-west-1.amazonses.com (client-ip=54.240.3.20; helo=a3-20.smtp-out.eu-west-1.amazonses.com; envelope-from=010201816a108c94-79c51f2e-cca3-4d5e-a018-f784f42c9281-000000@eu-west-1.amazonses.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=expoplatform.com header.i=@expoplatform.com header.a=rsa-sha256 header.s=mqy4nq24v44agy3wx43syyt7rieosr22 header.b=ZT8Kn/7s;
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn header.b=NMoDQ1DE;
	dkim-atps=neutral
X-Greylist: delayed 436 seconds by postgrey-1.36 at boromir; Thu, 16 Jun 2022 11:18:38 AEST
Received: from a3-20.smtp-out.eu-west-1.amazonses.com (a3-20.smtp-out.eu-west-1.amazonses.com [54.240.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNkp62BnHz3bfC
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jun 2022 11:18:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=mqy4nq24v44agy3wx43syyt7rieosr22; d=expoplatform.com;
	t=1655341878;
	h=Date:From:Reply-To:Message-ID:MIME-Version:Content-Type:To:Subject;
	bh=Wda7BkK2SPWtwJbbOmSBUU871X0Hh+wn6cDUGP+kG10=;
	b=ZT8Kn/7sVdgCJFt1g933tkNZvfStsxmA0jR9QSNqzMlNSPF9urTpiXXDgbXmArNr
	FlWVzbcW0UFrZbHyW3QA8V/NDDJFJa6lS3JYdAgyYqUNNmi9tmfUznTqlH9o/NRZ7cs
	4MU4iQVQW6bEFJwMr5yqZvq9wTek0CeX8F1peCJk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1655341878;
	h=Date:From:Reply-To:Message-ID:MIME-Version:Content-Type:To:Subject:Feedback-ID;
	bh=Wda7BkK2SPWtwJbbOmSBUU871X0Hh+wn6cDUGP+kG10=;
	b=NMoDQ1DEq+lR5S6Vo7/bJknfpC6/k5Sn4kjjGgAn3mkZ5AI55NmoK5HeGJEBvAUJ
	cc7+mGmLsx3ZNoiu3YU4b6kI2z5sbtL9WoIFzoYK/woJINFtyKI9zQ8o2Zt5llT9VZN
	AG4TqGtQ/0Z1EjayyswUcy5V+2I3KSaeBjY9ENaY=
Date: Thu, 16 Jun 2022 01:11:18 +0000
From: NBE20 Website <noreply@expoplatform.com>
Message-ID: <010201816a108c94-79c51f2e-cca3-4d5e-a018-f784f42c9281-000000@eu-west-1.amazonses.com>
X-Mailer: PHPMailer 6.5.0 (https://github.com/PHPMailer/PHPMailer)
url: =?us-ascii?Q?https://api-newstart.expoplatform.com/index/ses?=
 =?us-ascii?Q?status?=
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
To: linux-erofs@lists.ozlabs.org
Subject: Thank you for your enquiry
Feedback-ID: 1.eu-west-1.rw81kvIovACgqEi+EGyvFo5hfqvsssubVRIHHkv0GI4=:AmazonSES
X-SES-Outgoing: 2022.06.16-54.240.3.20
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
Reply-To: hello@nseventsgroup.co.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <title>TITLE</title>
  
  <style type="text/css" data-inline="true">
    body{ Margin: 0; padding: 0; }
    img{ border: 0px; display: block; }

    .socialLinks{ font-size: 6px; }
    .socialLinks a{
      display: inline-block;
    }
    .socialIcon{
      display: inline-block;
      vertical-align: top;
      padding-bottom: 0px;
      border-radius: 100%;
    }
    .oldwebkit{ max-width: 570px; }
    td.vb-outer{ padding-left: 9px; padding-right: 9px; }
    table.vb-container, table.vb-row, table.vb-content{
      border-collapse: separate;
    }
    table.vb-row{
      border-spacing: 9px;
    }
    table.vb-row.halfpad{
      border-spacing: 0;
      padding-left: 9px;
      padding-right: 9px;
    }
    table.vb-row.fullwidth{
      border-spacing: 0;
      padding: 0;
    }
    table.vb-container{
      padding-left: 18px;
      padding-right: 18px;
    }
    table.vb-container.fullpad{
      border-spacing: 18px;
      padding-left: 0;
      padding-right: 0;
    }
    table.vb-container.halfpad{
      border-spacing: 9px;
      padding-left: 9px;
      padding-right: 9px;
    }
    table.vb-container.fullwidth{
      padding-left: 0;
      padding-right: 0;
    }
  </style>
  <style type="text/css">
    /* yahoo, hotmail */
    .ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div{ line-height: 100%; }
    .yshortcuts a{ border-bottom: none !important; }
    .vb-outer{ min-width: 0 !important; }
    .RMsgBdy, .ExternalClass{
      width: 100%;
      background-color: #9e9e9e;
      background-color: #ffffff}

    /* outlook */
    table{ mso-table-rspace: 0pt; mso-table-lspace: 0pt; }
    #outlook a{ padding: 0; }
    img{ outline: none; text-decoration: none; border: none; -ms-interpolation-mode: bicubic; }
    a img{ border: none; }

    @media screen and (max-device-width: 600px), screen and (max-width: 600px) {
      table.vb-container, table.vb-row{
        width: 95% !important;
      }

      .mobile-hide{ display: none !important; }
      .mobile-textcenter{ text-align: center !important; }

      .mobile-full{
        float: none !important;
        width: 100% !important;
        max-width: none !important;
        padding-right: 0 !important;
        padding-left: 0 !important;
      }
      img.mobile-full{
        width: 100% !important;
        max-width: none !important;
        height: auto !important;
      }
    }
  </style>
  <style type="text/css" data-inline="true">
    
    #ko_sideArticleBlock_1 .links-color a, #ko_sideArticleBlock_1 .links-color a:link, #ko_sideArticleBlock_1 .links-color a:visited, #ko_sideArticleBlock_1 .links-color a:hover{
      color: #000000;
      color: #000000;
      text-decoration: underline
    }
     #ko_sideArticleBlock_1 .long-text p{ Margin: 0px }  #ko_sideArticleBlock_1 .long-text p:last-child{ Margin-bottom: 0px }  #ko_sideArticleBlock_1 .long-text p:first-child{ Margin-top: 0px } 
    #ko_footerBlock_1 .links-color a, #ko_footerBlock_1 .links-color a:link, #ko_footerBlock_1 .links-color a:visited, #ko_footerBlock_1 .links-color a:hover{
      color: #cccccc;
      color: #cccccc;
      text-decoration: underline
    }
     #ko_footerBlock_1 .long-text p{ Margin: 0px }  #ko_footerBlock_1 .long-text p:last-child{ Margin-bottom: 0px }  #ko_footerBlock_1 .long-text p:first-child{ Margin-top: 0px } </style>
</head>
<body bgcolor="#ffffff" text="#D2D0D0" alink="#cccccc" vlink="#cccccc" style="background-color: #ffffff; color: #D2D0D0;">

  <center>

  <!-- preheaderBlock -->
  
  <!-- /preheaderBlock -->

  <table class="vb-outer" width="100%" cellpadding="0" border="0" cellspacing="0" bgcolor="#ffffff" style="background-color: #ffffff;" id="ko_sideArticleBlock_1">
    <tbody><tr>
      <td class="vb-outer" align="center" valign="top" bgcolor="#ffffff" style="background-color: #ffffff;">

<!--[if (gte mso 9)|(lte ie 8)]><table align="center" border="0" cellspacing="0" cellpadding="0" width="570"><tr><td align="center" valign="top"><![endif]-->
        <div class="oldwebkit">
        <table width="570" border="0" cellpadding="0" cellspacing="9" class="vb-row fullpad" bgcolor="#ffffff" style="width: 100%; max-width: 570px; background-color: #ffffff;">
          <tbody><tr>
            <td align="center" class="mobile-row" valign="top" style="font-size: 0;">

<!--[if (gte mso 9)|(lte ie 8)]><table align="center" border="0" cellspacing="0" cellpadding="0" width="552"><tr><![endif]-->
<!--[if (gte mso 9)|(lte ie 8)]>
<td align="left" valign="top" width="368">
<![endif]--><div class="mobile-full" style="display: inline-block; max-width: 368px; vertical-align: top; width: 100%;">

                    <table class="vb-content" border="0" cellspacing="9" cellpadding="0" width="368" align="left" style="width: 100%;">
                      <tbody><tr>
                        <td style="font-size: 18px; font-family: Arial, Helvetica, sans-serif; color: #000000; text-align: left;">
                          <span style="color: #000000;">Thank you for sending your enquiry</span>
                        </td>
                      </tr>
                      <tr>
                        <td align="left" class="long-text links-color" style="text-align: left; font-size: 13px; font-family: Arial, Helvetica, sans-serif; color: #000000;"><p>One of our team will be in touch soon on the contact details you provided to discuss the sponsorship options.<br><br>Many Thanks,<br><span style="color: rgb(0, 204, 255);" data-mce-style="color: #00ccff;"><strong>The NBE Team</strong></span></p></td>
                      </tr>
                      
                    </tbody></table>
</div><!--[if (gte mso 9)|(lte ie 8)]></td>
<![endif]--><!--[if (gte mso 9)|(lte ie 8)]>
<td align="left" valign="top" width="184" style="; ">
<![endif]--><div class="mobile-full" style="display: inline-block; max-width: 184px; vertical-align: top; width: 100%;">

                    <table class="vb-content" border="0" cellspacing="9" cellpadding="0" width="184" align="left" style="width: 100%;">
                      <tbody><tr>
                        <td width="100%" valign="top" align="left" class="links-color">
                          
                            <img border="0" hspace="0" vspace="0" width="166" class="mobile-full" alt="" style="vertical-align: top; width: 100%; height: auto; max-width: 166px;" src="https://api-newstart.expoplatform.com/eimg/?src=https%3A%2F%2Fdi9mr54a05a64.cloudfront.net%2Fapi-newstart.expoplatform.com%2Fgallery%2FMTU1NDk5ODE3ODVjYWY2M2EyNWM4MjU%3D.png&amp;method=resize&amp;params=166%2Cnull">
                          
                        </td>
                      </tr>
                    </tbody></table>

</div>
<!--[if (gte mso 9)|(lte ie 8)]></td><![endif]-->

<!--[if (gte mso 9)|(lte ie 8)]></tr></table><![endif]-->

            </td>
          </tr>
        </tbody></table>
        </div>
<!--[if (gte mso 9)|(lte ie 8)]></td></tr></table><![endif]-->
      </td>
    </tr>
  </tbody></table>

  <!-- footerBlock -->
  
  </center>
  <div style="display: none;"><img src="https://api-newstart.expoplatform.com/opened/?e=linux-erofs@lists.ozlabs.org&act=tr&en=customform_autoanswer_105&eid=156&src=wellcome.png" width="0" height="0"/></div>

</body></html>
